BRIDGE="$1" 
# please replace BRIDGE_NAME with what we found in last step. e.g. br-27256e...

VETH=$(brctl show | grep $BRIDGE | awk '{print $4}')
echo "The controller virtual interface: $VETH"
echo "Remove $VETH from $BRIDGE"
sudo brctl delif $BRIDGE $VETH
echo "Add $VETH to br-lan"
sudo brctl addif br-lan $VETH
