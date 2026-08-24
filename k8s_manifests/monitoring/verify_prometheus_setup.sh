#!/bin/bash

kubectl get pods -n monitoring
kubectl get pvc -n monitoring
kubectl get secret grafana-admin-secret -n monitoring
kubectl get pods -n monitoring -1 app.kubernetes.io/name=grafana
