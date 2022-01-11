#!/bin/bash

# check if rules are set
sudo iptables -F
sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
sudo iptables -A FORWARD -i wlan0 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i eth0 -o wlan0 -j ACCEPT

# set up default route
DEFAULT_IFACE=`route -n | grep -E "^0.0.0.0 .+UG" | awk '{print $8}'`
if [ "$DEFAULT_IFACE" != "wlan0" ]; then
	GW=`route -n | grep -E "^0.0.0.0 .+UG .+wlan0$" | awk '{print $2}'`
	sudo route del default $DEFAULT_IFACE
	sudo route add default gw $GW wlan0
fi
sudo iptables -t nat -A PREROUTING -p tcp -i wlan0 -j DNAT --to-destination 192.168.34.10
sudo iptables -A FORWARD -p tcp -d 192.168.34.10 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
