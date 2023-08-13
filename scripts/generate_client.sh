#!/bin/bash

# Provide the client name as an argument
if [ $# -eq 0 ]; then
  echo "Usage: $0 <client-name>"
  exit 1
fi

CFG_DIR='/etc/openvpn/openvpn-config'
IP=$(wget -qO- https://ifconfig.me/ip)
client_name="$1"

# Create a directory for the OpenVPN client setup
mkdir -p $CFG_DIR/$client_name
cd $CFG_DIR/$client_name

# Generate client key and certificate
openssl genpkey -algorithm RSA -out $client_name.key
openssl req -new -key $client_name.key -out $client_name.csr -subj "/CN=$client_name"
openssl x509 -req -in $client_name.csr -CA $CFG_DIR/ca.crt -CAkey $CFG_DIR/ca.key -CAcreateserial -out $client_name.crt

# Create client configuration file
cat <<EOF > $client_name.ovpn
client
dev tun
proto udp
remote $IP 1194
resolv-retry infinite
nobind
persist-key
persist-tun
key-direction 1
remote-cert-tls server
cipher AES-256-CBC
verb 3
<ca>
$(cat $CFG_DIR/ca.crt)
</ca>
<cert>
$(cat $client_name.crt)
</cert>
<key>
$(cat $client_name.key)
</key>
<tls-auth>
$(cat $CFG_DIR/ta.key)
</tls-auth>
EOF

echo "OpenVPN client files for $client_name ($client_name.ovpn, $client_name.crt, $client_name.key) generated successfully."
