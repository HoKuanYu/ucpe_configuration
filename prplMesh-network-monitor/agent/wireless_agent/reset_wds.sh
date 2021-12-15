uci set wireless.wifinet2.disabled='1'
uci set wireless.wifinet4.disabled='0'
uci commit wireless
/etc/init.d/network restart
/etc/init.d/prplmesh restart
