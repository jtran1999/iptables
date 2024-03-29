#!/bin/bash
echo
echo Deleting non IP entries
echo "#!/bin/bash" > newrules
echo "iptables -F" >> newrules
echo "iptables -X" >> newrules
echo Addling entry for iptable logging
echo "iptables -A INPUT -j LOG --log-prefix "inputdrop" -m limit --limit 30/m --log-level 6" >> newrules
echo Concatenate sorted IP addresses to newrules
cat sorted >> newrules
echo Adding rules for sshd and httpd
echo "iptables -A INPUT -p tcp --dport 22 -j ACCEPT" >> newrules
echo "iptables -A INPUT -p tcp --dport 80 -j ACCEPT" >> newrules
echo Adding command to list new rules at the end of the newrules script
echo "iptables -L -n" >> newrules
cat newrules > addrules
num=`cat sorted |wc -l`
echo Activatiing new rules
sleep 1
./addrules
echo
echo There are currently $num lines in iptables
echo This should be the first rule in the a sorted addrules table
awk 'NR >= '5' && NR <= '5'' addrules
echo done
