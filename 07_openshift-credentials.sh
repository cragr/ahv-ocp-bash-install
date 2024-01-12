#!/bin/bash

set -e

KUBEADMIN_PASSWORD=$(cat ~/openshift/auth/kubeadmin-password)

mkdir -p $HOME/.kube/
cp ~/openshift/auth/kubeconfig $HOME/.kube/config

echo "kubeadmin_password=$KUBEADMIN_PASSWORD"
