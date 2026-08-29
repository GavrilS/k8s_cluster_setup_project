#!/bin/bash

# Install CNI (Container Network Interface) plugging to allow networking in the cluster to 
# work. The script accepts an argument specifying which one should be installed. Choices 
# include: Flannel (simple & lightweight) - the default option, Calico (rich feature set, 
# support network policies) and Cilium (high performance, eBPF-based)

# 1. Take the plugging name from the arguments passed if there is any, else assign flannel
# as the default one and convert the value to lowercase
PLUGGIN_NAME=$(echo "${1:-flannel}" | tr '[:upper:]' '[:lower:]')
echo "The chosen pluggin to install is $PLUGGIN_NAME"

case $PLUGGIN_NAME in

    flannel)
        echo "Installing Flannel"
        kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
        ;;
    
    calico)
        echo "Installing Calico"
        kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.0/manifests/calico.yaml
        ;;

    cilium)
        echo "Installing Cilium"
        helm repo add cilium https://helm.cilium.io/
        helm install cilium cilium/cilium --namespace kube-system
        ;;
    
    *)
        echo "$PLUGGIN_NAME is not an option. Available options are flannel, calico or cilium"
        ;;

esac
