#! /bin/bash

cat rx_poc.log
yesterday_fc=$(tail -n 2 rx_poc.log | head -n 1 |
 grep -oE '[+-]?[0-9]+\([0-9]+\)' | grep -oE '[0-9]+' | head -3 | tail -1)
today_obs=$(tail -1 rx_poc.log | head -1 |
 grep -oE '[+-]?[0-9]+\([0-9]+\)' | grep -oE '[0-9]+' | head -1 | tail -1)
accuracy=$(($yesterday_fc-$today_obs))

echo "today temp $today_obs and yesterday forecast $yesterday_fc"

if [ -1 -le $accuracy ] && [ $accuracy -le 1 ]
then
   accuracy_range=excellent
elif [ -2 -le $accuracy ] && [ $accuracy -le 2 ]
then
    accuracy_range=good
elif [ -3 -le $accuracy ] && [ $accuracy -le 3 ]
then
    accuracy_range=fair
else
    accuracy_range=poor
fi

echo "Forecast accuracy is $accuracy_range"

row=$(tail -1 rx_poc.log)
year=$( echo $row | cut -d " " -f1)
month=$( echo $row | cut -d " " -f2)
day=$( echo $row | cut -d " " -f3)
echo -e "$year\t$month\t$day\t$today_temp\t$yesterday_fc\t$accuracy\t$accuracy_range" >> historical_fc_accuracy.tsv
