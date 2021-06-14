#!/bin/bash
#is the internet working?
#Usage: ./is-the-internet-working.sh [targetA] [targetB] [routerIP]
#example: ./is-the-internet-working.sh 1.1.1.1 8.8.8.8 192.168.1.1

targetA=$1
targetB=$2
router=$3

delay=1 #delay 1 second between pings
wait=1 #wait 1 second for reply
pings=2 #ping this many times
naptime=60 #how long between tests

if [ $# -eq 0 ]; then
	targetA=8.8.8.8 #google
	targetB=1.1.1.1 #cloudflare
	router=192.168.29.117 #Ethernet
else
	echo "Start monitor for network timeouts at `date` for $minutes minute(s)."
	echo "Target host: $targetA  $targetB  $router"
fi

while true; do
	if ! ping $targetA -i $delay -W $wait -c $pings >& /dev/null && \
	! ping $targetB -i $delay -W $wait -c $pings >& /dev/null; then
		if ping $router -i $delay -W $wait -c $pings >& /dev/null; then
			#no reply from the web servers, reply from router
			echo "$(date): the internet is down"
			echo "$(date): the internet is down" >> ping-log.txt
		else echo "$(date): the router is down" #no reply from the router
		echo "$(date): the router is down" >> ping-log.txt; fi
	else echo "$(date): the internet is alive" #reply from one of the webservers
	echo "$(date): the internet is alive" >> ping-log.txt; fi
	sleep $naptime
done


# | grep -i "timeout\|unreachable\|no answer\|statistics\|transmitted\|avg"
#ping 1.1.1.1 -i 1 -c 4 --apple-time | tee pinglog.txt
#ping 1.1.1.1 -i 1 -c 4 | while read pong; do echo "$(date): $pong"; done | tee pinglog.txt

#once per minute, append this to a log and display
#ping target A 2-times then target B 2-times with 1s wait time
#if either return TRUE then print the internet and the router is working
#if neither return TRUE then ping the router
#if the router returns TRUE then the internet is not working 
#if the router returns FALSE then the router is not working
#if ping 1.1.1.1 -i 1 -W 1 -c 2 >& /dev/null ; then echo something; fi