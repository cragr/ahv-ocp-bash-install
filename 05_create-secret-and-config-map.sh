#!/bin/bash

set -e

source 00_set-variables.sh

cd ~/openshift

# Configure credentials secret
cat > manifests/openshift-cloud-controller-manager-nutanix-credentials-credentials.yaml <<EOF
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
            \"username\":\"${PC_USERNAME}\", 
            \"password\":\"${PC_PASSWORD}\"}, 
            \"prismElements\":null
          }
    }]"
EOF

# Configure cloud-conf configmap
cat > manifests/openshift-cloud-controller-manager-cloud-config.yaml <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: cloud-conf
  namespace: openshift-cloud-controller-manager
data:
  cloud.conf: "{
      \"prismCentral\": {
          \"address\": \"${PRISM_CENTRAL_FQDN}\",
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
