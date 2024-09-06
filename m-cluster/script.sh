#!/bin/bash

# Add and update Helm repositories
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

# Create the Kubernetes Secret using Helm hook or a pre-defined script
kubectl -n thanos create secret generic thanos-storage --from-file=thanos.yaml=/home/cloudshell-user/script/thanos-storage-config.yaml

# Install the Helm chart with custom values
helm install kube-prometheus -f /home/cloudshell-user/script/values.yaml bitnami/kube-prometheus -n thanos

# Install EBS CSI driver
eksctl create addon --name aws-ebs-csi-driver --cluster clusterv5 --region us-east-1 --service-account-role-arn arn:aws:iam::481665114398:role/AmazonEKS_EBS_CLI_DriverRole --force
eksctl utils associate-iam-oidc-provider --cluster clusterv5 --region us-east-1 --approve

