#!/bin/bash

source 00_set-variables.sh

# Configure iSCSI machineconfig
cat > ./$INSTALL_DIR/openshift/99-master-ntnx-csi-enable-iscsid.yaml <<EOF
apiVersion: machineconfiguration.openshift.io/v1
kind: MachineConfig
metadata:
  labels:
    machineconfiguration.openshift.io/role: master
  name: 99-master-ntnx-csi-enable-iscsid
spec:
  config:
    ignition:
      version: 3.2.0
    systemd:
      units:
        - enabled: true
          name: iscsid.service
EOF

cat > ./$INSTALL_DIR/openshift/99-worker-ntnx-csi-enable-iscsid.yaml <<EOF
apiVersion: machineconfiguration.openshift.io/v1
kind: MachineConfig
metadata:
  labels:
    machineconfiguration.openshift.io/role: worker
  name: 99-worker-ntnx-csi-enable-iscsid
spec:
  config:
    ignition:
      version: 3.2.0
    systemd:
      units:
        - enabled: true
          name: iscsid.service
EOF

# Create cloud-config ConfigMap
cat > ./$INSTALL_DIR/manifests/openshift-cloud-controller-manager-cloud-config.yaml <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: cloud-conf
  namespace: openshift-cloud-controller-manager
data:
  cloud.conf: "{
      \"prismCentral\": {
          \"address\": \"$PRISM_CENTRAL_FQDN\",
          \"port\": 9440,
            \"credentialRef\": {
                \"kind\": \"Secret\",
                \"name\": \"nutanix-credentials\",
                \"namespace\": \"openshift-cloud-controller-manager\"
            }
       },
       \"topologyDiscovery\": {
           \"type\": \"Prism\",
           \"topologyCategories\": null
       },
       \"enableCustomLabeling\": true
     }"
EOF

# Create cloud-config ConfigMap
cat > ./$INSTALL_DIR/manifests/openshift-cloud-controller-manager-nutanix-credentials-credentials.yaml <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: nutanix-credentials
  namespace: openshift-cloud-controller-manager
type: Opaque
stringData:
  credentials: "[{
    \"type\":\"basic_auth\",
    \"data\":{
          \"prismCentral\":{
            \"username\":\"$PC_USERNAME\", 
            \"password\":\"$PC_PASSWORD\"}, 
            \"prismElements\":null
          }
    }]"
EOF