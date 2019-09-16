# iptables
IPtables rules for ubuntu 18.04.3 lts iptable Linux firewall

- Updated 9/16/2019
	* Order of operation: ./ip-sort.sh, ./create-sorted-addrules.sh, then for now manually cat newrules >addrules, and finally ./addrules to apply new rules.
	* copying newrules to addrules will be updated once verified to be robust
	* Sorting is now fulling automated. No editing required to clean up sorted file.

- Updated 9/15/2019
	* Should work with any Linux distro that uses iptables
	* added a script to cat addrules and numerically sort the IPs and outputs to sorted
	* added checking for IP that already exist in database
	* showmeip script just checks for IPs and reports results or suggest what to do.
	* added banip.sh has conditional checking and will add IP if it doesn't exist
	* add a script to generate new rules from a sorted file of IP addresses
	* first sort cat addrules |sort > sorted, then run create-sorted-addrules.sh to generate new news with sorted list of IP numbers.

- Project Begins
	* I want to create a script that will create iptables(firewall) rules that will block any IP addresses that scan my computer and tries to log in without permission.
	* all of the default rules will be created by running a script called addrules.
Add rules to file with:
	* Follow (tailf) /var/log/auth/log to see what IPs are trying to access my system via sshd without my permission.
	* To add the IPs to the file addrules to generate the firewall tules run the following command.

sed -i '/^iptables -A INPUT -s 51.38.33.178/ i iptables -A INPUT -s 40.78.100.11/32  -p TCP -j DROP' addrules

	* or edit addrules directly

	* or run the banip.sh:
	  ./banip.sh

	* give ip address to ban. done

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

	-…or create a new repository on the command line
	* echo "# iptables" >> README.md
	* git init
	* git add README.md
	* git commit -m "first commit"
	* git remote add origin git@github.com:jtran1999/iptables.git
	* git push -u origin master
	  …or push an existing repository from the command line
	* git remote add origin git@github.com:jtran1999/iptables.git
	* git push -u origin master
	  …or import code from another repository
	* You can initialize this repository with code from a Subversion, Mercurial, or TFS project.



