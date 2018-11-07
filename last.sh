#!/usr/bin/sh
LANG=en_US.UTF-8
export LANG
today=`date '+%a %b %d'|sed 's/0//'`
export today
/usr/lib/acct/fwtmp < /var/adm/wtmpx | grep "$today"' .*2018'| cut -d \  -f 1 | sort | uniq 
