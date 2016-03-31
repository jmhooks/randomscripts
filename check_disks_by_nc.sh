PROGNAME=`basename $0`
PROGPATH=`echo $0 | sed -e 's,[\\/][^\\/][^\\/]*$,,'`
if [ "$0" == "./$PROGNAME" ]; then
        PROGPATH="$(pwd)/${PROGPATH//./}"
fi

. $PROGPATH/utils.sh

usage() {
        echo ""
        echo "This script checks host MD for alive/spare disks"
        echo ""
        echo "Usage:"
        echo "$0 -m <ALIVE/SPARE> -c <CRIT>"
        exit $STATE_UNKNOWN
}

# The following is generic. 
while getopts ":c:m:h:a:" opt; do
        case $opt in
                m )     MESG=$OPTARG ;;
                c )     CRIT=$OPTARG ;;
                a )     ALIAS=$OPTARG;;
                h )     HOST="$OPTARG" ;;
                \?|h )  usage
                        exit $STATE_UNKNOWN
        esac
done

# pass subshel via telnet (nc) to get drive status.
VALUE=`{ echo "fs l d"; sleep 1; } | nc $HOST 23 | grep $MESG | wc -l`

# if the reponse is equal to the critical flag, the status is good
if [ $VALUE  -eq $CRIT ]; then
        if [ "$MESG" == "alive" ]; then
            echo "OK - There are "$VALUE" drives "$MESG" (out of "$CRIT") on "$ALIAS".|"$PERFDATA
            exit $STATE_OK
        fi
        if [ "$MESG" == "spare" ]; then
            echo "OK - There are "$VALUE" "$MESG" drives (out of "$CRIT") on "$ALIAS".|"$PERFDATA
            exit $STATE_OK
        fi

# if the response is less than or equal to the critical flag, the status is bad
elif [ $VALUE -le $CRIT ]; then
        if [ "$MESG" == "alive" ]; then
            echo "CRITICAL - There are "$VALUE" drives "$MESG" (out of "$CRIT") on "$ALIAS".|"$PERFDATA
            exit $STATE_CRITICAL
        fi
        if [ "$MESG" == "spare" ]; then
            echo "CRITICAL - There are "$VALUE" "$MESG" drives (out of "$CRIT") on "$ALIAS".|"$PERFDATA
            exit $STATE_CRITICAL
        fi

# if VALUE is not set or MESG is lower than the drive count
else
        echo "UNKNOWN - status for disks on "$ALIAS".|"$PERFDATA
        exit $STATE_CRITICAL
fi
