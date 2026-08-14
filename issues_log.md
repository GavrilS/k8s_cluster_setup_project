# A log of encountered issues/problems and resolutions
---

1. The first issue I encountered was trying to create the virtual machines that would play 
the role of the nodes in the kubernetes cluster. After installing VirtualBox, Vagrant and 
Ansible with the script 'tools/install_requirements.sh' and running 'vagrant up' inside 
the 'vagrant' folder, I hit an error during creating the first VM putting the VM in 
'Guru meditation' state. After some debugging, I was able to discover that the version of 
VirtualBox installed by the Ubuntu repositories has some issue when running on an Ubuntu 
22.04 with an AMD processor.

The way I resolved the issue is by uninstalling the outdated version of VirtualBox and 
installing a newer one with the script 'tools/install_virtualbox.sh'. Since vagrant 
installed by the script is using the older version from the Ubuntu repository, it was 
not able to run the newer virtualbox and resulted in another error. I resolved it by 
uninstalling vagrant and installing a newer version directly from Hashicorp with the 
'tools/install_vagrant.sh' script.

---
