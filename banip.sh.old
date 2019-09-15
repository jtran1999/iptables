#!/bin/bash
read -p 'IP to ban: ' ipaddr
echo The ip to ban is $ipaddr
echo $1
sed -i "/^iptables -A INPUT -j LOG/a iptables -A INPUT -s $ipaddr/32 -p tcp -j DROP" addrules
./addrules
echo
echo
echo
echo this is in the active firewall rules
iptables -L -n |grep $ipaddr
echo
echo
echo
echo this is in the addrules file
grep $ipaddr addrules
echo done
