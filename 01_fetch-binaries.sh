#!/bin/bash

source 00_set-variables.sh

mkdir -p /tmp/ocp-tools
cd /tmp/ocp-tools

curl -Ls -o ccoctl-linux.tar.gz https://github.com/okd-project/okd/releases/download/4.17.0-okd-scos.0/ccoctl-linux-4.17.0-okd-scos.0.tar.gz
curl -Ls -o openshift-client-linux.tar.gz https://github.com/okd-project/okd/releases/download/4.17.0-okd-scos.0/openshift-client-linux-4.17.0-okd-scos.0.tar.gz
curl -Ls -o openshift-install-linux.tar.gz https://github.com/okd-project/okd/releases/download/4.17.0-okd-scos.0/openshift-install-linux-4.17.0-okd-scos.0.tar.gz
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