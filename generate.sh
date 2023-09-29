#!/bin/bash

talosctl gen config --with-secrets secrets.yaml --config-patch-control-plane @controlplane.common.yaml --output-types controlplane --force -o controlplane.yaml home https://api.k8s.jacob.network:6443
talosctl machineconfig patch controlplane.yaml --patch @alpha.patch.yaml --output alpha.yaml
talosctl machineconfig patch controlplane.yaml --patch @beta.patch.yaml --output beta.yaml
talosctl machineconfig patch controlplane.yaml --patch @gamma.patch.yaml --output gamma.yaml
