# Commands for Vagrant

- vagrant up - starts/creates all VMs defined in the Vagrantfile
- vagrant destroy -f - forces all VMs to be destroyed
- vagrant suspend - freeze and save the live RAM state of all VMs
- vagrant resume - turn the VMs back on
- vagrant halt - stops the vagrant VMs
- vagrant ssh-config - get the ssh configs for the VMs
- vagrant ssh-config > vagrant-ssh - save the configs to a file called 'vagrant-ssh'
- vagrant ssh [name|id] - ssh into the VM that is specified by [name|id]; if [name|id] is 
not specified, it will try to ssh in a VM called 'default'
