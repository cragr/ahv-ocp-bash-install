#!/bin/bash

# Specify Cluster Name, Prism Central password, and OpenShift Version
export CLUSTER_NAME=okdlab            # Ex: homelab1 homelab2
export PC_PASSWORD=Nutanix/4u            # Located 
export VERSION=4.17.0   #Version List - https://mirror.openshift.com/pub/openshift-v4/clients/ocp/

# Common variables
export PRISM_CENTRAL_FQDN=prism-central.lab.mydc.dev
export INSTALL_DIR=./ocp-install
export RELEASE_ARCH=amd64
export BASE_DOMAIN=mydc.dev
export PC_USERNAME=admin
export PULL_SECRET="$(< pull_secret)"
export SSH_KEY="$(< id_rsa_ocp.pub)"
export CLUSTER_NETWORK=10.128.0.0/14
export SERVICE_NETWORK=172.30.0.0/16

# cluster specific variables
if [ $CLUSTER_NAME = 'okdlab' ]; then
    export NTNX_PE_SUBNET_UUID=34004d18-7119-4a4d-8f2b-410b30141a17
    export NTNX_PE_UUID=00063002-8083-7b9c-50ea-3448ede7ae8b
    export MACHINE_NETWORK=192.168.10.0/23
    export API_VIP=192.168.10.11
    export INGRESS_VIP=192.168.10.12
    export PE_ENDPOINT=192.168.10.25
    export DATA_SERVICE_ENDPOINT=192.168.10.26
    export STORAGE_CONTAINER=okdlab
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