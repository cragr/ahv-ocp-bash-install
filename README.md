# OpenShift IPI Deployment on Nutanix

This repository contains the necessary scripts and configuration files to deploy Red Hat OpenShift using the Installer-Provisioned Infrastructure (IPI) method on Nutanix platforms.

## Overview

The Installer-Provisioned Infrastructure approach automates the OpenShift installation process on Nutanix. It simplifies the deployment by managing the underlying infrastructure setup automatically.

## Prerequisites

- Access to a Nutanix cluster with sufficient resources.
- Red Hat OpenShift subscription or evaluation license.  A no-cost developer subscrption is sufficient.
- Nutanix credentials with adequate permissions.
- Access to the official documentation at https://docs.openshift.com/container-platform/4.14/installing/installing_nutanix/installing-nutanix-installer-provisioned.html

## Configuration

Before initiating the deployment, configure the following elements:

### SSH Key

Replace the `id_rsa_ocp.pub` file with your own SSH public key. This key is used for secure access to OpenShift nodes during and after the installation.

1. Generate a new SSH key pair, if you don't have one:

```
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa_ocp
```

2. Replace the `id_rsa_ocp.pub` file in the repository with your generated public key.

### Pull Secret

Update the `pull_secret` file with your Red Hat pull secret.

1. Obtain your pull secret from the [Red Hat OpenShift Cluster Manager](https://cloud.redhat.com/openshift/install).
2. Replace the content of the `pull_secret` file in the repository with your pull secret.

## Deployment

To deploy OpenShift on Nutanix, follow these steps:

1. Clone the repository:

```
git clone https://github.com/cragr/ahv-ocp-bash-install
``````

2. Navigate to the repository directory:
```
cd ahv-ocp-bash-install
```

3. Update the `00_set-variables.sh` file with values matching your environment.


4. Run the deployment scripts one at a time starting with 01_fetch_binaries.sh:
```
./01_fetch_binaries.sh
```

## Post-Deployment

After successful deployment, you can access your OpenShift cluster:

1. Use the OpenShift web console URL provided at the end of the installation.
2. Log in using the credentials provided by the installation process.

## Contributing

Contributions to this repository are welcome.

## License

This project is licensed under the [MIT License](LICENSE).

## Support

For support and queries, raise an issue in the repository or contact the maintainers.