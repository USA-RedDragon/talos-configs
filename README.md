# Talos Configs

This is a repository containing my personal [Talos](https://www.talos.dev/) configs. I name my nodes after the Greek alphabet, so the files follow this naming convention. The nodes are AMD-based systems, except for `gamma` which is an AMD CPU but an Nvidia GPU. These nodes have my [home cluster Flux repository](https://github.com/USA-RedDragon/home-cluster-flux) running on them.

## Usage

The `generate.sh` script uses Talos' `talosctl` to generate the configs. If you don't have an existing `secrets.yaml` file, it will generate one for you. This script also generates YAML files for each node by taking the node-specific patches in `nodename.patch.yaml` along with the base config in `controlplane.common.yaml` and merging them together. These configs are named `nodename.yaml` and should be in the `.gitignore` file, as these contain secrets and certificates.

Example output:

```bash
$ ./generate.sh
Note: No secrets.yaml found, using 'talosctl gen secrets' to create it...
Warning: Save your secrets.yaml somewhere safe!
generating PKI and tokens
Created controlplane.yaml
```

Then, apply the node configs with `talosctl -n ip.to.your.node apply-config -f nodename.yaml`

## Modifying

If you want to use these configs as a base for your own, you can fork this repository and modify the `controlplane.common.yaml` file to your liking and modify the extensions in `schematic.*yaml`. You can also modify the `nodename.patch.yaml` files to change the node-specific configs. If you want to add more nodes, you can create a new `nodename.patch.yaml` file and add it to the `generate.sh` script.

## Wants/TODOs

- Disk encryption
- Ability to configure RAID0 for the root partition
