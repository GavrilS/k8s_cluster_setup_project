# A project to set up a multi-node kubernetes cluster
---

# Requirements

This project is to be run on a Linux based OS. It is developed and tested on Ubuntu.

- OS: Linux based
- Software Tools:
    Vagrant
    Ansible
    VirtualBox

===

# Steps

1. Install the required software to set up the cluster. This can be done by running the 'install_requirements.sh' script.

* How to use the script:

> chmod +x install_requirements.sh
> sudo ./install_requirements.sh

===

2. Spin 3 VMs with a Linux distribution to build the cluster - 1 master node and 2 worker nodes. Set up the networking - ensure all VMs have static IP addresses and can ping each other. Disable swap space on all machines (k8s requires swap to be off to function properly). For this purpose I have added a vagrant config file in 'vagrant/Vagrantfile' that spins the VMs and runs ansible to do all setup across the nodes. The ansible setup is located in 'ansible/'.

* How to apply the config:

> cd vagrant
> vagrant up

===
