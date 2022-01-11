# rpi-wifi-to-ethernet
Setup scripts to allow for the Raspberry Pi to share it's wifi network through to the ethernet port. This allows a device connected to the ethernet port to have network access.
## Setup
Run the following command on the raspberry pi to install and start the forwarding.  
```
sudo ./setup.sh
```
## How It Works
This will install a service that executes the inet_forward.sh script at boot after the network is available. That script will forward all ports to 192.168.34.10 which is the device connected to ethernet.

## Ansible
The ansible directory was added to include the same script to install the forward service over ssh.  Please update the `ansible/ansible_hosts` file with the IP needed.
To install run the following:  
```bash
cd ansible
ansible-playbook -i ansible_hosts forward.yml
```