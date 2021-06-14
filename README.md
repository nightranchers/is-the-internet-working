# is-the-internet-working
Simple ping script to log internet connection status

defaults:
perform test once per minute
ping each IP twice
wait 1 second for reply
delay 1 second between pings

Relies on a crontab entry:
* * * * * bash -l -c "/Users/Ricky/is-the-internet-working.sh" >> /Users/Ricky/\
ping-log.txt

Writes to a log file ping-log.txt
You may view this live with the command
tail -f /Users/Ricky/ping-log.txt

If you don't use cron, here's the usage
#Usage: ./is-the-internet-working.sh [targetA] [targetB] [routerIP]
#example: ./is-the-internet-working.sh 1.1.1.1 8.8.8.8 192.168.1.1
pick your two favorite external IP addresses to perform the ping test and your local router local IP
if the external addresses fail, it will test the router

