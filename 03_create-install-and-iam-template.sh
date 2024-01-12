#!/bin/bash

set -e

source 00_set-variables.sh

cd ~/openshift

INDENTED_CERT=$( cat ca.crt | awk '{ print " ", $0 }' )

cat > install-config.yaml <<EOF
apiVersion: v1
baseDomain: ${BASE_DOMAIN}
compute:
- architecture: ${RELEASE_ARCH}
  hyperthreading: Enabled
  name: worker
  platform: {}
  replicas: 3
controlPlane:
  architecture: ${RELEASE_ARCH}
  hyperthreading: Enabled
  name: master
  platform: {}
  replicas: 3
credentialsMode: Manual
metadata:
  creationTimestamp: null
  name: ${CLUSTER_NAME}
networking:
  clusterNetwork:
  - cidr: ${CLUSTER_NETWORK}
    hostPrefix: 23
  machineNetwork:
  - cidr: ${MACHINE_NETWORK}
  networkType: OVNKubernetes
  serviceNetwork:
  - 172.30.0.0/16
platform:
  nutanix:
    apiVIPs:
    - ${API_VIP}
    ingressVIPs:
    - ${INGRESS_VIP}
    prismCentral:
      endpoint:
        address: ${PRISM_CENTRAL_FQDN}
        port: 9440
      password: ${PC_PASSWORD}
      username: ${PC_USERNAME}
    prismElements:
    - endpoint:
        address: ${PE_ENDPOINT}
        port: 9440
      uuid: ${NTNX_PE_UUID}
    subnetUUIDs:
    - ${NTNX_PE_SUBNET_UUID}
publish: External
pullSecret: ${PULL_SECRET}
sshKey: |+
  ${SSH_KEY}
additionalTrustBundle: |
${INDENTED_CERT}
EOF

cat > iam.yaml <<EOF
credentials:
- type: basic_auth
  data:
    prismCentral:
      username: ${PC_USERNAME}
      password: ${PC_PASSWORD}
EOF
