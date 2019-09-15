#!/bin/bash
read -p 'IP to look for: ' ip
echo
echo var is $ip
if grep -Fq $ip  addrules
then
    echo Ip already exist in addrules
    iptables -L -n |grep $ip
    # code if found
else
    echo does not exist, it needs to be added to addrules
    echo adding ip to addrules and processing updates
    sed -i "/^iptables -A INPUT -j LOG/a iptables -A INPUT -s $ipaddr/32 -p tcp -j DROP" addrules
    ./addrules
    iptables -L -n |grep $ip 
    # code if not found
fi
echo
echo done

