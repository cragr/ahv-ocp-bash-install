#!/bin/bash

# Specify Cluster Name, Prism Central password, and OpenShift Version
export CLUSTER_NAME=            # Ex: homelab1 homelab2
export PC_PASSWORD=             # Located 
export VERSION=4.14.10   #Version List - https://mirror.openshift.com/pub/openshift-v4/clients/ocp/

# Common variables
export PRISM_CENTRAL_FQDN=prism-central.mydc.dev
export INSTALL_DIR=./ocp-install
export RELEASE_ARCH=amd64
export BASE_DOMAIN=mydc.dev
export PC_USERNAME=admin
export PULL_SECRET="$(< pull_secret)"
export SSH_KEY="$(< id_rsa_ocp.pub)"
export CLUSTER_NETWORK=10.128.0.0/14
export SERVICE_NETWORK=172.30.0.0/16

# cluster specific variables
if [ $CLUSTER_NAME = 'homelab1' ]; then
    export NTNX_PE_SUBNET_UUID=251ddf3f-2eb8-4947-b330-5d60911d4305
    export NTNX_PE_UUID=00060e9d-43b4-5243-791b-246e963cb590
    export MACHINE_NETWORK=192.168.10.0/23
    export API_VIP=192.168.10.21
    export INGRESS_VIP=192.168.10.22
    export PE_ENDPOINT=192.168.10.17
    export DATA_SERVICE_ENDPOINT=
    export STORAGE_CONTAINER=homelab1-volumes
else
    :
fi

# cluster specific variables
if [ $CLUSTER_NAME = 'homelab2' ]; then
    export NTNX_PE_SUBNET_UUID=
    export NTNX_PE_UUID=
    export MACHINE_NETWORK=192.168.10.0/23
    export API_VIP=
    export INGRESS_VIP=
    export PE_ENDPOINT=192.168.10.17
    export DATA_SERVICE_ENDPOINT=
    export STORAGE_CONTAINER=homelab2-volumes
else
    :
fi

# Announce error if CLUSTER_NAME or PC_PASSWORD is empty
[ -z "$CLUSTER_NAME" ] && echo "Error: The variable CLUSTER_NAME has not been defined in the 00-set-variables.sh file"
[ -z "$PC_PASSWORD" ] && echo "Error: The variable PC_PASSWORD has not been defined in the 00-set-variables.sh file"