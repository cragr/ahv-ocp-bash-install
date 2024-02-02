#!/bin/bash

source 00_set-variables.sh

mkdir -p ./$INSTALL_DIR/iam

INDENTED_CERT=$( cat ./"${INSTALL_DIR}"/ca.crt | awk '{ print " ", $0 }' )

cat > ./$INSTALL_DIR/install-config.yaml <<EOF
additionalTrustBundlePolicy: Proxyonly
apiVersion: v1
baseDomain: ${BASE_DOMAIN}
compute:
- architecture: ${RELEASE_ARCH}
  hyperthreading: Enabled
  name: worker
  platform:
    nutanix:
      categories:
      - key: AppType
        value: Openshift
      - key: AppTier
        value: Openshift_Compute
  replicas: 3  
controlPlane:
  architecture: ${RELEASE_ARCH}
  hyperthreading: Enabled
  name: master
  platform:
    nutanix:
      categories:
      - key: AppType
        value: Openshift
      - key: AppTier
        value: Openshift_Controlplane
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
  - ${SERVICE_NETWORK}
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
    defaultMachinePlatform:
      bootType: Legacy
      categories:
      - key: AppType
        value: Openshift
publish: External
pullSecret: ${PULL_SECRET}
sshKey: |+
  ${SSH_KEY}
EOF

cat > ./$INSTALL_DIR/iam/iam.yaml <<EOF
credentials:
- type: basic_auth
  data:
    prismCentral:
      username: ${PC_USERNAME}
      password: ${PC_PASSWORD}
EOF