#!/bin/bash

# 1. Add the helm repo
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# 2. Create a namespace
kubectl apply -f namespace.yaml

#. 3. Create a secret for Grafana
kubectl apply -f grafana_secret.yaml

# 4. Install
helm upgrade --install kube-prometheus-stack prometheus-community/kube-prometheus-stack \
    --namespace monitoring \
    -f values.yaml
