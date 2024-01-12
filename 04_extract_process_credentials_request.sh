#!/bin/bash

set -e

cd ~/openshift

RELEASE_IMAGE=$(openshift-install version | awk '/release image/ {print $3}')

# Extract the list of CredentialsRequest custom resources (CRs) from the OpenShift Container
oc adm release extract --from=$RELEASE_IMAGE --credentials-requests --included --install-config=./install-config.yaml --to=./creds

# Use the ccoctl tool to process all CredentialsRequest objects
ccoctl nutanix create-shared-secrets --credentials-requests-dir=./creds --output-dir=./ --credentials-source-filepath=./iam.yaml

# Create manifests
openshift-install create manifests --dir ./
