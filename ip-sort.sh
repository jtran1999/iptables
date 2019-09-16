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
