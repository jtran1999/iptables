#!/bin/bash
echo Creating sorted
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
total=`cat sorted |wc -l`
echo $total iptables rules in total have been sorted
echo Reseting last count to 5
echo 5 > last
last=`cat last`
echo This is the new value for last: $last
count=`cat count`
echo This is the new value for var count: $count
echo This is the output with last var resetted to $last
echo "Test the awk command with awk 'NR >= '$count' && NR <= '$last'' addrules"
awk 'NR >= '$count' && NR <= '$last'' addrules
echo done
