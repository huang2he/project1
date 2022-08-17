#!/bin/sh

# wait for system a while
#sleep 60

# periodic print CPU and Mem usage                                                                                                                                                                                                                                                               
while true; do                                                                                                                                                                                                                                                                           
                                                                                                                                                                                                                                                                                         
# CPU Ratio
IdleRatio=`top -n 1 | grep CPU: | awk -F " " '{print $8}'`
echo $IdleRatio
IdleNumber=${IdleRatio%%%*}
echo $IdleNumber
# Minus float calculation
CPUratio=`awk "BEGIN {print ((100-${IdleNumber})/100)}"`
echo $CPUratio

# Mem Ratio

MemInfo=`free -m | grep Mem:`
TotalMem=`echo "$MemInfo" | awk -F " " '{print $2}'`
UsedMem=`echo "$MemInfo" | awk -F " " '{print $3}'`
echo $TotalMem
echo $UsedMem
MemRatio=`awk "BEGIN {print ($UsedMem/$TotalMem)}"`
echo ${MemRatio}
MemRatio=${MemRatio:0:5}
echo $MemRatio

				  
# get date & set file name                                                                                                                                                                                                                                                       
CurrentDate=`date`                                                                                                                                                                                                                                                               
FileNameDate=`date +%Y%m%d`                                                                                                                                                                                                                                                      
CurrentDayLogFile="/ysdisk/support/tmp/CPU-Mem-$FileNameDate.csv"                                                                                                                                                                                                             
                                                                                                                                                                                                                                                                                         
# add table header                                                                                                                                                                                                                                                               
if [ -e $CurrentDayLogFile ];then                                                                                                                                                                                                                                                
	echo "File exists" > /dev/null                                                                                                                                                                                                                                                   
else                                                                                                                                                                                                                                                                             
	echo "Time,CPUratio,Memoryratio" >> /ysdisk/support/tmp/CPU-Mem-$FileNameDate.csv                                                                                                                                                                           
fi                                                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                                                         
# insert cpu and mem usage                                                                                                                                                                                                                                                   
echo "$CurrentDate,$CPUratio,$MemRatio" >> /ysdisk/support/tmp/CPU-Mem-$FileNameDate.csv                                                                                                                                                                          
                                                                                                                                                                                                                                                                                      
# set print period                                                                                                                                                                                                                                                                                        
sleep 10                                                                                                                                                                                                                                                                                 
                                                                                                                                                                                                                                                                                         
done
