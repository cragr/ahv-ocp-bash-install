#!/bin/bash

source 00_set-variables.sh

RELEASE_IMAGE=$(openshift-install version | awk '/release image/ {print $3}')

# Extract the list of CredentialsRequest custom resources (CRs) from the OpenShift Container
oc adm release extract --from=$RELEASE_IMAGE --credentials-requests --included --install-config=./$INSTALL_DIR/install-config.yaml --to=./$INSTALL_DIR/credential_requests

# Use the ccoctl tool to process all CredentialsRequest objects
ccoctl nutanix create-shared-secrets --credentials-requests-dir=./$INSTALL_DIR/credential_requests --output-dir=./$INSTALL_DIR/ccoctl --credentials-source-filepath=./$INSTALL_DIR/iam/iam.yaml

# Create manifests
openshift-install create manifests --dir ./$INSTALL_DIR

# Copy the generated credential files
cp ./$INSTALL_DIR/ccoctl/manifests/*credentials.yaml ./$INSTALL_DIR/manifests