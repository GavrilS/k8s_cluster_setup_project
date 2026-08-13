#!/bin/bash

# Additional configuration for virtualbox on ubuntu after installing it with the ./install_requirements.sh script.

# Step 1 - load the required VirtualBox networking drivers. If the commands complete without errors, VirtualBox will have access to /dev/vboxnetctl.
sudo modprobe vboxnetadp
sudo modprobe vboxnetflt

# Step 2 - If the modprobe commands say Module vboxnetadp not found, your VirtualBox network drivers failed to compile against your current host kernel. Rebuild all VirtualBox kernel modules cleanly:

# Ensure kernel build tools are installed
sudo apt update
sudo apt install -y dkms build-essential linux-headers-$(uname -r)
sudo apt install --reinstall virtualbox-dkms

# Reconfigure and build all VirtualBox modules
sudo dpkg-reconfigure virtualbox-dkms

# After reconfiguring, load all virtualbox drivers:
sudo modprobe -a vboxdrv vboxnetadp vboxnetflt

# Step 3 - Verify the Host-Only interface creation
VBoxManage hostonlyif create

# If it prints something like Interface 'vboxnet0' was successfully created, the network system is fully operational.
