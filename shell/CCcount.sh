#!/bin/sh

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/ysdisk/ysapps/pbxcenter/lib/

# wait for Asterisk
# sleep 120

# record cc per 10 seconds;
while true;do

# PJSIP/trunk-后面可以指定名字
ActiveCall=`asterisk -rx "core show channels" | grep PJSIP/trunk- | grep Up | wc -l`
#echo "Connected call is $ActiveCall"

RingingCall=`asterisk -rx "core show channels" | grep PJSIP/trunk- | grep Ring | wc -l`
#echo "Ringing call is $RingingCall"

let "Total=$ActiveCall+$RingingCall"
#echo "Total calls is $Total"

CurrentDate=`date`
FileNameDate=`date +%Y%m%d`

CurrentDayLogFile="/ysdisk/support/tmp/DailyCallCurrents$FileNameDate.csv"
#echo $CurrentDayLogFile

if [ -e $CurrentDayLogFile ];then
	echo "File exists" > /dev/null
	else
	echo "Time,Total calls,Active calls,Ringing calls" >> /ysdisk/support/tmp/DailyCallCurrents$FileNameDate.csv
fi

echo "$CurrentDate,$Total,$ActiveCall,$RingingCall" >> /ysdisk/support/tmp/DailyCallCurrents$FileNameDate.csv

let "Total=0"
#echo "Total clear, now it is $Total"

# delete file more than 7 days
find /ysdisk/syslog/ -name "*.csv" -mtime +7 -exec rm -f {} \;

sleep 10

done
