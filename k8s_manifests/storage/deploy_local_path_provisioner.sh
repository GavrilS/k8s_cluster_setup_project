#!/bin/bash

# 1. Deploy - apply the latest manifest directly from the official GitHub repository - 
# creates a namespace, service accounts, RBAC roles, the provisioner deployment and a 
# StorageClass
echo "Deploy the local-path storage class with all required resources for it to work"
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/v0.0.31/deploy/local-path-storage.yaml
echo ""

# 2. Verify the installation
echo "\nVerify the installation"
kubectl get pods -n local-path-storage
echo ""

# 3. Set local-path as the Default Storage Class - the provisioner will handle any PVC that
# doesn't explicitly specify 'storageClassName'
echo "\nSet local-path as the default storage class"
kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
echo ""

# 4. Verify the storage class
echo "\nVerify the storage class"
kubectl get storageclass
echo ""