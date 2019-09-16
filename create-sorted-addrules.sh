#!/bin/bash
echo
echo "#!/bin/bash" > newrules
echo "iptables -F" >> newrules
echo "iptables -X" >> newrules
echo "iptables -A INPUT -j LOG --log-prefix "inputdrop" -m limit --limit 30/m --log-level 6" >> newrules
cat sorted >> newrules
echo "iptables -A INPUT -p tcp --dport 22 -j ACCEPT" >> newrules
echo "iptables -A INPUT -p tcp --dport 80 -j ACCEPT" >> newrules
echo "iptables -L -n" >> newrules
