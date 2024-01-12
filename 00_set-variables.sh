#!/bin/bash

#Version List - https://mirror.openshift.com/pub/openshift-v4/clients/ocp/
export VERSION=4.14.7
export RELEASE_ARCH=amd64
export CLUSTER_NAME=lab2
export NTNX_PE_SUBNET_UUID=251ddf3f-2eb8-4947-b330-5d60911d4305
export NTNX_PE_UUID=00060e9d-43b4-5243-791b-246e963cb590
export PRISM_CENTRAL_FQDN=prism-central.mydc.dev
export BASE_DOMAIN=mydc.dev
export CLUSTER_NETWORK=10.128.0.0/14  # Ensure other cluster networks do not overlap.
export MACHINE_NETWORK=192.168.10.0/23
export API_VIP=192.168.10.21
export INGRESS_VIP=192.168.10.22
export PC_USERNAME=ocpadmin
export PC_PASSWORD=Nutanix/4u
export PE_ENDPOINT=192.168.10.17
export PULL_SECRET="$(< pull_secret)"
export SSH_KEY="$(< id_rsa_ocp.pub)"
