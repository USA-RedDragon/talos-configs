---
apiVersion: v1alpha1
kind: ExtensionServiceConfig
name: tailscale
environment:
  - TS_AUTHKEY=${TS_AUTHKEY}
  - TS_ROUTES=192.168.1.0/24
  - TS_USERSPACE=false
  - TS_ACCEPT_DNS=false
