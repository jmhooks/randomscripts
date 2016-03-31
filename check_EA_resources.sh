#!/bin/bash

PROGNAME=`basename $0`
PROGPATH=`echo $0 | sed -e 's,[\\/][^\\/][^\\/]*$,,'`
if [ "$0" == "./$PROGNAME" ]; then
        PROGPATH="$(pwd)/${PROGPATH//./}"
fi

. $PROGPATH/utils.sh

usage() {
        echo ""
        echo "This script checks Grid A/B file count in EditAnywhere/EA_Resources"
        echo ""
        echo "Usage:"
        echo "$0 -w <WARN> -c <CRIT> -g <GRIDSIDE>"
        exit $STATE_UNKNOWN
}

# The following is generic. 
while getopts ":w:c:g:" opt; do
        case $opt in
                w )     WARN=$OPTARG ;;
                c )     CRIT=$OPTARG ;;
                g )     GRIDSIDE="$OPTARG" ;;
                \?|h )  usage
                        exit $STATE_UNKNOWN
        esac
done


if [ $GRIDSIDE == "B" ]; then
    GRID="10.191.6.8"

elif [ $GRIDSIDE == "A" ]; then
    GRID="10.191.4.11"
else
    echo "Unkown grid entry"
fi

# ls | wc on atlmasapp-prod1
VALUE=`ssh -C nagios@10.191.14.216 "ls /mnt/$GRID/atl-fs/EditAnywhere/EA_resources/ | wc -l"`

# if the response is below 29900, file count is good
if [ $VALUE -lt $WARN ]; then
        echo "OK - There are "$VALUE" files (out of 30000) on EditAnywhere/EA_resources/  "$PERFDATA
        exit $STATE_OK

# if the response is between 29900 and 29975, warning is issued
elif [ $VALUE -lt $CRIT ]; then
        echo "WARNING - There are "$VALUE" files (out of 30000) on EditAnywhere/EA_resources/  "$PERFDATA
        exit $STATE_WARNING

# if the response is greater than 29975, critical status is issued
elif [ $VALUE -ge $CRIT ]; then
        echo "CRITICAL - There are "$VALUE" files (out of 30000) on EditAnywhere/EA_resources/  "$PERFDATA
        exit $STATE_CRITICAL

# if VALUE is not set or not evaluated
else
        echo "UNKNOWN - Unkown status for file count on EditAnywhere/EA_resources | "$PERFDATA
        exit $STATE_UNKOWN
fi
