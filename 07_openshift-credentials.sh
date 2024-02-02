#!/bin/bash

source 00_set-variables.sh

KUBEADMIN_PASSWORD=$(cat ${INSTALL_DIR}/auth/kubeadmin-password)

mkdir -p $HOME/.kube/
cp ./$INSTALL_DIR/auth/kubeconfig $HOME/.kube/config

echo "kubeadmin_password=$KUBEADMIN_PASSWORD"