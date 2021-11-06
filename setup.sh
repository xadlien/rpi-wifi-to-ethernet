#!/bin/bash

# install script
cp inet_forward.sh /usr/local/bin/inet_forward.sh
chmod 755 /usr/local/bin/inet_forward.sh

# setup systemd service
cp inet_forward.service /etc/systemd/system/inet_forward.service
systemctl daemon-reload
systemctl enable inet_forward
systemctl start inet_forward
