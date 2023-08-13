# Simple OpenVPN Server Deployment using Docker

This repository provides a straightforward way to deploy an OpenVPN server using Docker. The deployment process is simple, making use of a `make` command and a little patience. Once completed, you'll have a functional OpenVPN server up and running.

## Usage

1. Clone this repository to your host machine.

2. Open a terminal and navigate to the repository directory.

3. Run the following command:

   ```bash
   make
   ```

This command will initiate the deployment process. Please allow some time for the server setup to complete.

Once the deployment is finished, a folder named client1 will be downloaded from the container. This folder contains all the necessary client details, including the .ovpn file. You can use this .ovpn file to connect to your newly deployed OpenVPN server.

## Prerequisites

Before you begin, make sure your host machine meets the following requirements:

Docker must be installed and running on the host machine. If Docker is not installed, you can download and install it from the Docker website: https://www.docker.com/get-started.

The VPN client and the Docker host should be running on different machines.

## Notes

The deployment process is designed to be user-friendly, requiring minimal intervention.
The repository's structure and scripts facilitate the setup of an OpenVPN server with ease.
Please reach out if you encounter any issues or have questions regarding the deployment process.

Disclaimer: This repository provides a simplified deployment of an OpenVPN server for educational and testing purposes. Make sure to consider security best practices when deploying OpenVPN in a production environment.
