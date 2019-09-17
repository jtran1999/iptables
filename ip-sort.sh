#!/bin/bash
cat addrules | sort -n > sorted
sed -i '1d' sorted
sed -i "/iptables -F/d" sorted
sed -i "/iptables -X/d" sorted
sed -i '1d' sorted
sed -i "/iptables -A INPUT -p tcp --dport 22 -j ACCEPT/d" sorted
sed -i "/iptables -A INPUT -p tcp --dport 80 -j ACCEPT/d" sorted
sed -i "/iptables -L -n/d" sorted
cat sorted
echo IPs sorted in the file sorted
echo To create new rules with sorted IP file, use create-sorted-addrules.sh to create new addrules
echo done
