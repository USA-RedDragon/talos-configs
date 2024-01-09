#!/bin/bash
TALOS_VERSION=v1.6.1

talosctl gen config --with-secrets secrets.yaml --config-patch-control-plane @controlplane.common.yaml --output-types controlplane --force -o controlplane.yaml home https://api.k8s.jacob.network:6443
talosctl machineconfig patch controlplane.yaml --patch @alpha.patch.yaml --output alpha.yaml
talosctl machineconfig patch controlplane.yaml --patch @beta.patch.yaml --output beta.yaml
talosctl machineconfig patch controlplane.yaml --patch @gamma.patch.yaml --output gamma.yaml

INSTALLER_ID=$(curl -fSsL -X POST --data-binary @schematic.yaml https://factory.talos.dev/schematics | jq -r .id)
echo Installer ID is ${INSTALLER_ID}
GAMMA_INSTALLER_ID=$(curl -fSsL -X POST --data-binary @schematic.gamma.yaml https://factory.talos.dev/schematics | jq -r .id)
echo Gamma Installer ID is ${GAMMA_INSTALLER_ID}

export INSTALLER_IMAGE="factory.talos.dev/installer/${INSTALLER_ID}:${TALOS_VERSION}"
export GAMMA_INSTALLER_IMAGE="factory.talos.dev/installer/${GAMMA_INSTALLER_ID}:${TALOS_VERSION}"

yq -i '.machine.install.image = strenv(INSTALLER_IMAGE)' alpha.yaml
yq -i '.machine.install.image = strenv(INSTALLER_IMAGE)' beta.yaml
yq -i '.machine.install.image = strenv(GAMMA_INSTALLER_IMAGE)' gamma.yaml
