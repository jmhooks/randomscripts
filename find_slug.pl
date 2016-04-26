#!/usr/bin/perl
use strict;
#use warnings;
use LWP::Simple;
use Term::ReadKey;
use JSON qw( decode_json );
use Encode qw(encode_utf8);
use Time::HiRes qw(usleep nanosleep);
use utf8;
use Try::Tiny;

my $result;
my $token;
my $rawJson;
my $dataJson;

#Check for argument
if($ARGV[0] eq ""){
    print("Usage: ./find_slug.pl <filename>\n");
    exit;
}

#Send user and password to obtain authentication token
my $rawAuth = get("http://msatlanta.turner.com/omneonserver/rest/cnn.bmam?returnFormat=json&domain=BMAM&method=getAuthToken&username=srv_core_api&password=fd908ew3qolkj4g8");
my $authJson = decode_json($rawAuth);
$token = $authJson->{'response'}{'payload'}{'authenticationToken'};
print "Authentication token: " . $token . "\n";
select(undef, undef, undef, 0.2);

#Take in filename from first argument contained MS ID's
my $file = $ARGV[0];
open my $info, $file or die "Could not open $file: $!";

#Go through each line of the file and send a request using the authentication token and MS ID, parse the JSON, and print out the slug information
while( my $line = <$info>){
    
    #Strip each line of any extra characters (.mxf mostly)
    $line =~ s/[^0-9 ]//g;
    
    #HTTP request for authentication token and slug name within the try block
    try{
        $rawJson = get("http://msatlanta.turner.com/omneonserver/rest/cnn.bmam?returnFormat=json&&authenticationToken=" . $authJson->{'response'}{'payload'}{'authenticationToken'} . "&method=getAsset&cnnAssetId=" . $line);
        $dataJson = decode_json($rawJson);
        $result = $dataJson->{'response'}{'payload'}{'slug'};
        
        #If token is invalid, retry until a valid one is received
        while($dataJson->{'response'}{'error'}{'message'} eq "Invalid authentication token"){
            $rawAuth = get("http://msatlanta.turner.com/omneonserver/rest/cnn.bmam?returnFormat=json&domain=BMAM&method=getAuthToken&username=srv_core_api&password=fd908ew3qolkj4g8");
            $authJson = decode_json($rawAuth);
            $rawJson = get("http://msatlanta.turner.com/omneonserver/rest/cnn.bmam?returnFormat=json&&authenticationToken=" . $authJson->{'response'}{'payload'}{'authenticationToken'} . "&method=getAsset&cnnAssetId=" . $line);
            $dataJson = decode_json($rawJson);
            select(undef, undef, undef, 0.1);
        }
        if($dataJson->{'response'}{'error'}{'code'} eq "MISSING_ASSET"){
           $result = "!! ERROR: Asset not found !!";
        }
        else {
           $result = $dataJson->{'response'}{'payload'}{'slug'};
        }
        
        #Print the slug output here
        print $line . " -- " . $result . "\n";
    } 
    
    #Catch when a utf-8 encoding error is received and print an error message regarding it
    catch{
        print $line . " -- !! ERROR: Bad character in request. Cannot obtain slug !!\n";
    };

    #Delay 0.1 seconds
    select(undef, undef, undef, 0.1);
}

