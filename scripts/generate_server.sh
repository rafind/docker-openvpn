#!/bin/bash

CFG_DIR='/etc/openvpn/openvpn-config'

mkdir -p $CFG_DIR
cd $CFG_DIR

# Generate CA
openssl genpkey -algorithm RSA -out ca.key
openssl req -new -x509 -key ca.key -out ca.crt -subj "/CN=MyOpenVPNCACert"

# Generate server key and certificate
openssl genpkey -algorithm RSA -out server.key
openssl req -new -key server.key -out server.csr -subj "/CN=server"
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt

# Generate Diffie-Hellman parameters
openssl dhparam -out dh.pem 2048

# Generate TA key
openvpn --genkey secret ta.key

# Create OpenVPN server configuration file
cat <<EOF > server.conf
port 1194
proto udp
dev tun
ca $CFG_DIR/ca.crt
cert $CFG_DIR/server.crt
key $CFG_DIR/server.key
dh $CFG_DIR/dh.pem
server 10.8.0.0 255.255.255.0
topology subnet
ifconfig-pool-persist ipp.txt
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
push "redirect-gateway def1 bypass-dhcp"
keepalive 10 60
persist-tun
persist-key
tls-auth $CFG_DIR/ta.key 0
key-direction 0
data-ciphers AES-256-CBC
data-ciphers-fallback AES-256-CBC
user nobody
group nobody
status openvpn-status.log
verb 4
explicit-exit-notify 1
EOF

echo "OpenVPN server files (server.crt, server.key, ta.key, server.conf) generated successfully."