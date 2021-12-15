#!/bin/ash

while true
do
curl $1 -m 5 >/dev/null
if [ $? != 0 ] ; then
	echo "$1 down"
	if [ $(uci get wireless.wifinet2.disabled) == 0 ] ; then
		echo "switch wds"
		uci set wireless.wifinet2.disabled="1"
		uci set wireless.wifinet4.disabled="0"
	else
		echo "switch wds"                       
                uci set wireless.wifinet2.disabled="0"
                uci set wireless.wifinet4.disabled="1"
	fi
	uci commit wireless
	sleep 5
	/etc/init.d/network restart
	sleep 10
	/etc/init.d/prplmesh restart
	break
else
	echo "$1 alive"
fi
sleep 5
done
