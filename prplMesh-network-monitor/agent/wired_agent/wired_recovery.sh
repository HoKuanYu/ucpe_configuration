#!/bin/ash

# usage: nohup ./wired_backup_controller.sh 192.168.1.10 &

while true
do
curl $1 -m 5 >/dev/null
if [ $? != 0 ] ; then
	echo "$1 is down, restart prplmesh"
	/etc/init.d/prplmesh restart
	break
fi
sleep 5
done
