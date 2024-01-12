#!/bin/bash

set -e

cd ~/openshift

openshift-install create cluster --log-level=debug

while true
    do
        openshift-install wait-for bootstrap-complete | grep 'Bootstrap Complete'
        [ $? -eq 0 ] && break
    done

while true
    do
        openshift-install wait-for install-complete | grep 'Install Complete'
	[ $? -eq 0 ] && break
    done
 


