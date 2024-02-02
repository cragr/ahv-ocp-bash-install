#!/bin/bash

source 00_set-variables.sh

openshift-install destroy cluster --dir ${INSTALL_DIR} --log-level debug