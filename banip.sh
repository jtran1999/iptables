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
	    echo
	    echo
#	    num=`iptables -L -n |wc -l`
#	    echo There are $num of rules in iptables
	    var=`cat addrules|wc -l`
    	    var1=5
	    echo There are $((var-var1)) active rules in the firewall
	    # code if found
	else
	    echo Does not exist, it needs to be added to addrules
	    echo
	    echo Adding this ip to addrules and processing updates
	    echo
	    sed -i "/^iptables -A INPUT -j LOG/a iptables -A INPUT -s $ip/32 -p tcp -j DROP" addrules
	    ./addrules
	    rule=`iptables -L -n |grep $ip`
	    echo
	    echo The new rule is now active as $rule
	    echo
#	num=`iptables -L -n |wc -l`
#       echo There are $num of rules in iptables
	    var=`cat addrules|wc -l`
            var1=5
            echo There are $((var-var1)) active rules in the firewall
	    # code if not found
fi
echo
echo done
