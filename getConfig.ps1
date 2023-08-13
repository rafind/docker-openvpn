$containerName = "my-vpn-server"
$sourcePath = "/etc/openvpn/openvpn-config/client1"
$destinationPath = "."

while ($true) {
    docker cp "$containerName`:$sourcePath" "$destinationPath"
    if ($?) {
        Write-Host "File copied successfully"
        break
    }
    else {
        Write-Host "Waiting for client config..."
        Start-Sleep -Seconds 5
    }
}