#!/bin/bash

containerName="my-vpn-server"
sourcePath="/etc/openvpn/openvpn-config/client1"
destinationPath="."

while true; do
    docker cp "$containerName:$sourcePath" "$destinationPath"
    if [ $? -eq 0 ]; then
        echo "File copied successfully"
        break
    else
        echo "Waiting for client config..."
        sleep 5
    fi
done
