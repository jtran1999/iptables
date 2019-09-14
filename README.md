# iptables
IPtables rules for ubuntu iptable chain firewall

Add rules to file with:
sed -i '/^iptables -A INPUT -s 51.38.33.178/ i iptables -A INPUT -s 40.78.100.11/32  -p TCP -j DROP' addrules

or edit addrules directly

or run the banip.sh:
./banip.sh

give ip address to ban. done

This script begins by flushing all known chains and remove all add chains.
iptables -F
iptables -X

Then starts a chain to LOG to syslog (kernel) facilities under inputdrop keyword.

Then we add a line to DROP each hosts found to be scanning my computer's ssh daemon for weakness. 

Packets are just drop with no ACK.

If a packet traverse all the way down the chain without matching any host ip then it runs into two ACCEPT statements.

if a packet is for destination port 22 which is my sshd daemon it will be accepted for authentication.
the same with a packet on port 80 wich is the web server.

logging analysed multiple times a day. Any computer trying to access this computer without permission is added to the INPUT:DROP list.


