# Makefile for Docker-based OpenVPN server

# Docker image name and tag
IMAGE_NAME = my-vpn
IMAGE_TAG = latest
CONTAINER_NAME = my-vpn-server

# Detect OS
ifdef OS
	WINDOWS := 1
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		LINUX := 1
	endif
endif

.PHONY: all stop build run download_config clean

# Default target: build, run, and download_config
all: stop build run download_config

# Build Docker image
build:
	@echo "Building Docker image..."
	docker build -q -t $(IMAGE_NAME):$(IMAGE_TAG) .

# Run Docker container
run:
	@echo "Running Docker container..."
	docker run -d --rm -p 1194:1194/udp --device /dev/net/tun:/dev/net/tun --cap-add=NET_ADMIN --name $(CONTAINER_NAME) $(IMAGE_NAME):$(IMAGE_TAG)

# Download configuration based on the platform
download_config:
ifdef WINDOWS
	@echo "Downloading config on Windows"
	powershell -ExecutionPolicy Bypass -File getConfig.ps1
else ifdef LINUX
	@echo "Downloading config on Linux"
	./getConfig.sh
else
	@echo "Downloading config manually using docker cp"
endif

# Stop the container
stop:
	@echo "Stopping container..."
	-docker stop $(CONTAINER_NAME)

# Clean up Docker container and image
clean: stop
	@echo "Cleaning up..."
	-docker rmi $(IMAGE_NAME):$(IMAGE_TAG)

# Help target to display available targets
help:
	@echo "Usage:"
	@echo "  make all       : Build, run, and download_config"
	@echo "  make build     : Build the Docker image"
	@echo "  make run       : Run the Docker container"
	@echo "  make download_config : Download configuration based on platform"
	@echo "  make stop      : Stop the Docker container"	
	@echo "  make clean     : Stop container and remove image"
