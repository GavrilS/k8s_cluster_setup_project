#!/bin/bash

# 1. Add the Helm repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

# 2. Create a namespace
kubectl apply -f namespace.yaml

# 3. Install the chart - basic install
helm install ingress-nginx ingress-nginx/ingress-nginx \
    --namespace ingress-nginx \
    -f values.yaml
