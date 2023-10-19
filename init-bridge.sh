#!/bin/bash

if [[ -z $1 || -z $2  || -z $3 ]]
then
	echo "Usage:	$0 <input-interface> <output-interface> <gateway-ip>"
	echo "Example:	./init-bridge.sh enp4s0 wlp3s0 192.168.90.1"
else

	export IN_IFACE="$1"		# Input Interface
	export OUT_IFACE="$2"		# Output Interface
	export GATEWAY_IP="$3"		# Gateway IP Address (Assigned on Input Interface)

	sudo sysctl -w net.ipv4.ip_forward=1	# Enable IP Forwarding


	# Firewall Rules

	sudo iptables -F					# Clear Firewall rules
	sudo iptables -A OUTPUT -o $OUT_IFACE -j ACCEPT		# Accept OUTPUT rule
	sudo iptables -A INPUT -i  $IN_IFACE -j ACCEPT		# Accept INPUT rule
	sudo iptables -t nat -A POSTROUTING -o $OUT_IFACE -j MASQUERADE


	sudo iptables -A FORWARD -i $IN_IFACE -o $OUT_IFACE -j ACCEPT	# Add forward rule from input to output
	sudo iptables -A FORWARD -i $OUT_IFACE -o $IN_IFACE -j ACCEPT	# Add forward rule from output to input

	# Configure Interface and start DHCP Server
	sudo ./bin/busybox ifconfig $IN_IFACE $GATEWAY_IP
	sudo ./bin/busybox udhcpd -I $GATEWAY_IP dhcp.conf  -f

fi
