#!/bin/sh

set -euo pipefail

COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_CLEAR='\033[0m'

# renovate: datasource=github-releases depName=siderolabs/talos
TALOS_VERSION=v1.6.1

rm -rf alpha.yaml beta.yaml gamma.yaml controlplane.yaml

# If secrets.yaml doesn't exist, create it
if [ ! -f secrets.yaml ]; then
    echo -e "${COLOR_YELLOW}Note: ${COLOR_CLEAR}${COLOR_GREEN}No secrets.yaml found, using 'talosctl gen secrets' to create it...${COLOR_CLEAR}" >&2
    talosctl gen secrets
    echo -e "${COLOR_RED}Warning: Save your secrets.yaml somewhere safe!${COLOR_CLEAR}" >&2
fi

talosctl gen config --with-secrets secrets.yaml --config-patch-control-plane @controlplane.common.yaml --output-types controlplane --force -o controlplane.yaml home https://api.k8s.jacob.network:6443
talosctl machineconfig patch controlplane.yaml --patch @alpha.patch.yaml --output alpha.yaml
talosctl machineconfig patch controlplane.yaml --patch @beta.patch.yaml --output beta.yaml
talosctl machineconfig patch controlplane.yaml --patch @gamma.patch.yaml --output gamma.yaml

INSTALLER_ID=$(curl -fSsL -X POST --data-binary @schematic.yaml https://factory.talos.dev/schematics | jq -r .id)
GAMMA_INSTALLER_ID=$(curl -fSsL -X POST --data-binary @schematic.gamma.yaml https://factory.talos.dev/schematics | jq -r .id)

INSTALLER_IMAGE="factory.talos.dev/installer/${INSTALLER_ID}:${TALOS_VERSION}" yq -i '.machine.install.image = strenv(INSTALLER_IMAGE)' alpha.yaml
INSTALLER_IMAGE="factory.talos.dev/installer/${INSTALLER_ID}:${TALOS_VERSION}" yq -i '.machine.install.image = strenv(INSTALLER_IMAGE)' beta.yaml
GAMMA_INSTALLER_IMAGE="factory.talos.dev/installer/${GAMMA_INSTALLER_ID}:${TALOS_VERSION}" yq -i '.machine.install.image = strenv(GAMMA_INSTALLER_IMAGE)' gamma.yaml
