BRIDGE="br-1cb5c12b52bb" 
# please replace BRIDGE_NAME with what we found in setup step. e.g. br-27256e...
VETH=$(brctl show | grep $BRIDGE | awk '{print $4}')

while true
do
    curl $1 >/dev/null
    if [ $? != 0 ]
    then
        echo "backup controller start"
	sudo brctl delif $BRIDGE $VETH
        sudo brctl addif br-lan $VETH
        break
    else
        echo "$1 alive!"
    fi
sleep 5
done
