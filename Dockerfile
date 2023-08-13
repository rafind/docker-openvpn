# Use the Alpine Linux base image
FROM alpine:3.14

# Install OpenVPN and other necessary packages
RUN apk update && apk upgrade && \
    apk add --no-cache \
    bash \
    openssl \
    iptables \
    openvpn=2.5.6-r0

# Copy OpenVPN configuration files and certificates
COPY scripts /etc/openvpn/


# Expose the OpenVPN port
EXPOSE 1194/udp

WORKDIR /etc/openvpn/
ENTRYPOINT ["./docker_entrypoint.sh"]