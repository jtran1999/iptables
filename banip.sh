#!/bin/bash
read -p 'IP to look for: ' ip
#	echo var is $ip
	if grep -Fq $ip  addrules
	then
	    echo IP already exist in addrules
	    iptables -L -n |grep $ip
	    echo
#	    head -15 addrules
#	    num=`iptables -L -n |wc -l`
#	    echo There are $num of rules in iptables
	    var=`cat addrules|wc -l`
    	    var1=7
#	    echo There are $((var-var1)) active rules in the firewall
	    count=`cat count`
	    echo $count
	    last=`cat last`
	    echo $last
	    echo There are $((last - $count)) new rules added since the last sort!
	    echo These are all the new rules added since last sort
	    awk 'NR >= '$count' && NR <= '$last'' addrules
	    # code if found
	else
	    echo Does not exist, it needs to be added to addrules
	    echo Adding this ip to addrules and processing updates
	    sed -i "/^iptables -A INPUT -j LOG/a iptables -A INPUT -s $ip/32 -p tcp -j DROP" addrules
	    ./addrules
	    rule=`iptables -L -n |grep $ip`
	    echo
	    echo The new rule is now active as $rule
#	    head -15 addrules
#	num=`iptables -L -n |wc -l`
#       echo There are $num of rules in iptables
	    var=`cat addrules|wc -l`
            var1=7
            echo There are $((var-var1)) active rules in the firewall
	    count=`cat count`
	    echo $count
	    last=`cat last`
	    echo $((last+1)) >last
	    echo $last
	    echo There are $((last - $count)) new rules added since the last sort!
	    echo These are all the new rules added since last sort
	    awk 'NR >= '$count' && NR <= '$last'' addrules
	    last=`cat last`
	    echo Updated last count to $last
	    # code if not found
fi
echo done
