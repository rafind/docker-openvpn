#!/bin/bash
sh generate_server.sh
sh generate_client.sh client1
sysctl -w net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
iptables -A INPUT -p udp --dport 1194 -j ACCEPT
openvpn --config /etc/openvpn/openvpn-config/server.conf