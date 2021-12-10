#!/bin/bash

# install packages
apt update
apt install -y isc-dhcp-server

# copy dhcp config
cp configs/dhcpd.conf /etc/dhcp/
cp configs/isc-dhcp-server /etc/default/

# start dhcp
systemctl enable isc-dhcp-server
systemctl start isc-dhcp-server

# install script
cp inet_forward.sh /usr/local/bin/inet_forward.sh
chmod 755 /usr/local/bin/inet_forward.sh

# setup systemd service
cp inet_forward.service /etc/systemd/system/inet_forward.service
systemctl daemon-reload
systemctl enable inet_forward
systemctl start inet_forward
