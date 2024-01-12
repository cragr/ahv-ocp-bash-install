#!/bin/bash

set -e

source 00_set-variables.sh

mkdir ~/openshift
cd ~/openshift

# Download certificate
openssl s_client -showcerts -servername ${PRISM_CENTRAL_FQDN} -connect ${PRISM_CENTRAL_FQDN}:9440 </dev/null |  \
	sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' | \
    tee ca.crt

# Copy certificate to trust store
sudo cp ca.crt /etc/pki/ca-trust/source/anchors/openshift.crt

# Update trust store
sudo update-ca-trust

if curl https://${PRISM_CENTRAL_FQDN}:9440 &> /dev/null
then
    echo "Prism Central SSL certificate --> VALID"
else
    echo "=== Prism Central SSL certificate does not seem valid. Please make sure IP address and DNS are part of the SAN. ==="
    exit 1
fi
