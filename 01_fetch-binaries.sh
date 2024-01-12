#!/bin/bash

set -e

source 00_set-variables.sh

mkdir -p /tmp/ocp-tools
cd /tmp/ocp-tools

curl -Ls -o ccoctl-linux.tar.gz https://mirror.openshift.com/pub/openshift-v4/$RELEASE_ARCH/clients/ocp/$VERSION/ccoctl-linux.tar.gz
curl -Ls -o openshift-client-linux.tar.gz https://mirror.openshift.com/pub/openshift-v4/$RELEASE_ARCH/clients/ocp/$VERSION/openshift-client-linux.tar.gz
curl -Ls -o openshift-install-linux.tar.gz https://mirror.openshift.com/pub/openshift-v4/$RELEASE_ARCH/clients/ocp/$VERSION/openshift-install-linux.tar.gz

tar xzvf ccoctl-linux.tar.gz
tar xzvf openshift-client-linux.tar.gz
tar xzvf openshift-install-linux.tar.gz

chmod +x ./ccoctl ./oc ./openshift-install ./kubectl
sudo mv ./ccoctl /usr/local/bin/
sudo mv ./oc /usr/local/bin/
sudo mv ./openshift-install /usr/local/bin/
sudo mv ./kubectl /usr/local/bin/

cd /tmp
rm -fR /tmp/ocp-tools
