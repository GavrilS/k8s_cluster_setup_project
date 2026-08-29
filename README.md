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

3. Set up a workstation from which to check the status of the cluster and run kubectl/helm 
commands. To do this the workstation needs to have kubectl/helm installed and be configured
to be able to communicate with the kube-apiserver. This is done with the script 
'./tools/setup_workstation.sh'. Run the script with the following command:

> chmod +x ./tools/setup_workstation.sh
> ./tools/setup_workstation.sh

===

4. Install the different tools we want the cluster to have available:
    - for CSI we will use the local_path provisioner and use it to create a default 
    StorageClass;
    - for CNI I have created a script which allows you to install flannel, calico or cilium,
    however our initial provisioning already set up flannel, so unless we want to use one of
    the others, we can skip this step;
    - install an ingress controller - we will use the ingress nginx controller
    - install Prometheus/Grafana for monitoring

# Steps:

4.1 Set up CSI pluggin:

> cd k8s_manifests/storage/
> bash deploy_local_path_provisioner.sh

---

4.2 Set up CNI pluggin (optional):

> cd k8s_manifests/cni/
Run one of the followin:
> bash install_cni_pluggin.sh -> for installing flannel (already installed by default)
> bash install_cni_pluggin.sh calico -> for installing calico
> bash install_cni_pluggin.sh cilium -> for installing cilium

* I haven't tested configuring any of the above separately so these steps are missing from 
this project.

---

4.3 Install the ingress nginx controller to handle traffic

> cd k8s_manifests/ingress_nginx_controller/
> bash deploy_ingress_nginx_controller.sh

---

4.4 Install the Prometheus stack to enable monitoring in the cluster

> cd k8s_manifests/monitoring/
> bash deploy_prometheus_stack.sh
> bash verify_prometheus_setup.sh -> optional, to test if the different Prometheus components were properly installed

===
