#!/bin/bash

source 00_set-variables.sh

openshift-install create cluster --dir ./$INSTALL_DIR --log-level=debug