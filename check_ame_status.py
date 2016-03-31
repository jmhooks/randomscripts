#!/usr/bin/env python

import urllib2
import simplejson as json
import os
import sys
from optparse import OptionParser
import time

os.environ['PYTHON_EGG_CACHE'] = '/home/nagios/.python-eggs'

scriptversion = "1.0"

common_options = "snmpwalk -OvQ -v 1"


dataJson = json.load(urllib2.urlopen("http://msatlrctl-prod1.turner.com:8000/api/get_ame_status"))
for i in range(0,12):
    result = dataJson["response"]["payload"][i]["server_status"]
    if result == "Offline":
        time.sleep(5)
        resultAgain = dataJson["response"]["payload"][i]["server_status"]
        if resultAgain == "Offline":
            str = dataJson["response"]["payload"][i]["ame"]
            print "CRITICAL: " + str[:-5] + " is " + result.upper() + "!!!"
            sys.exit(2)
print "OK: All AMEs are ONLINE!"
sys.exit(0)
