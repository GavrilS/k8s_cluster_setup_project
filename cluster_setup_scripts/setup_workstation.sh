#!/bin/bash

echo "Get admin config from the controlplane node to the workstation"
mkdir -p ~/.kube
cd vagrant/
vagrant ssh k8s-master -c "sudo cat /etc/kubernetes/admin.conf" > ~/.kube/config
cd ../
sudo chown $(id -u):$(id -g) ~/.kube/config

echo "Install kubectl and get helm's binary on the workstation"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

echo "Test everything is set up properly"
kubectl get nodes
helm list -A
