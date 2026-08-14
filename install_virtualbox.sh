#!/bin/bash

# Install VirtualBox using Oracle's official build as the version from Ubuntu's repository is often out of date

sudo apt update

sudo apt install -y wget gpg

wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo gpg --dearmor -o /etc/apt/keyrings/oracle-virtualbox-2016.gpg

echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/oracle-virtualbox-2016.gpg] https://www.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list

sudo apt update

sudo apt install -y virtualbox-7.0

sudo usermod -aG vboxusers $USER
