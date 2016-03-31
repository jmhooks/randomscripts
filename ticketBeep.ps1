$data = 0
Remove-Variable data
$state = 0
$data = 23
while(1 -eq 1){
    #$data = Invoke-WebRequest "http://bcceng.turner.com/tv/gettickets.php"
    #$data = $data.ToString().Substring(0,1)
    #$data = [convert]::ToInt32($data, 10)
    
    $url = "http://bcceng.turner.com/tv/gettickets.php"
    $webclient = new-object System.Net.WebClient
    $data = $webclient.DownloadString($url)
    $data = $data.ToString().Substring(0,1)
    $data = [convert]::ToInt32($data, 10)

    Write-Host "-----------------"
    Write-Host "Data" $data
    Write-Host "First State" $state
    if ($state -lt $data){
        $state = $data
        [console]::beep(900,200)
        Write-Host "Second State" $state
    }
    elseif ($state -gt $data){
        $state = $data
        Write-Host "Second State" $state
    }
    
    Start-Sleep -s 5
    $data = $data + 1
}
