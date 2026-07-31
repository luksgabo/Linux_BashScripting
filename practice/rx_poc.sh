#! /usr/bin/bash
city_name=Casablanca
TZ="Africa/Casablanca"
weather_report=$(curl -s "wttr.in/$city_name?T") #T for no colors in html

temps=$(echo "$weather_report" | grep -Eo -e '[+-]?[0-9]+\([0-9]+\)[[:space:]]*°C')
obs_temp=$(echo "$temps" | head -n 1)
fc_temp=$(echo "$temps" | head -n 7 | tail -n 1)

echo "Current temperature for $city_name : $obs_temp"
echo "The forecasted temperature for noon tomorrow : $fc_temp"

# -E, --extended-regexp Interpret: PATTERNS as extended regular expressions (EREs).
# -e PATTERNS, --regexp=PATTERNS: Use PATTERNS as the patterns.
# -o , --only-matching: Print only the matched (non-empty) parts of a matching line, with each such part on a separate output line.

hour=$(TZ="$TZ" date +%H)
minutes=$(TZ="$TZ" date +%M)
day=$(TZ="$TZ" date -u +%d) 
month=$(TZ="$TZ" date +%m)
year=$(TZ="$TZ" date +%Y)

echo $hour:$minutes $day/$month/$year
header=$(echo -e "$day\t$month\t$year\t$obs_temp\t$fc_temp")
echo "$header" >> rx_poc.log
