#!/bin/bash
read -p 'IP to look for: ' ip
	echo
	echo var is $ip
	if grep -Fq $ip  addrules
	then
	    echo
	    echo IP already exist in addrules
	    echo
	    echo
	    iptables -L -n |grep $ip
	    # code if found
	else
	    echo Does not exist, it needs to be added to addrules
	    echo
	    echo
	    echo Adding ip to addrules and processing updates
	    echo
	    echo
	    sed -i "/^iptables -A INPUT -j LOG/a iptables -A INPUT -s $ip/32 -p tcp -j DROP" addrules
	    ./addrules
	    iptables -L -n |grep $ip 
	    # code if not found
fi
echo
echo done
