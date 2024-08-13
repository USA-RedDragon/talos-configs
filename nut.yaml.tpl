---
apiVersion: v1alpha1
kind: ExtensionServiceConfig
name: nut-client
configFiles:
  - content: |-
        MONITOR ${UPS_HOST} 1 ${UPS_USER} ${UPS_PASS} secondary
        SHUTDOWNCMD "/sbin/poweroff"
    mountPath: /usr/local/etc/nut/upsmon.conf
