#!/bin/bash

# Install MetalB - an open-source load-balancer implementation for bare-metal Kubernetes clusters
helm repo add metallb https://metallb.github.io/metallb
helm repo update
helm install metallb metallb/metallb \
  --create-namespace \
  --namespace metallb-system \
  --set controller.admissionWebhooks.enabled=false

# Verify the controller and speaker pods are running
echo "Verifying pods are running"
kubectl get pods -n metallb-system
