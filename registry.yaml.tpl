---
apiVersion: v1alpha1
kind: RegistryMirrorConfig
name: docker.io
endpoints:
  - url: https://jacob.pub/v2/docker.io
    overridePath: true
---
apiVersion: v1alpha1
kind: RegistryMirrorConfig
name: ghcr.io
endpoints:
  - url: https://jacob.pub/v2/ghcr.io
    overridePath: true
---
apiVersion: v1alpha1
kind: RegistryMirrorConfig
name: quay.io
endpoints:
  - url: https://jacob.pub/v2/quay.io
    overridePath: true
---
apiVersion: v1alpha1
kind: RegistryMirrorConfig
name: registry.k8s.io
endpoints:
  - url: https://jacob.pub/v2/registry.k8s.io
    overridePath: true
---
apiVersion: v1alpha1
kind: RegistryMirrorConfig
name: lscr.io
endpoints:
  - url: https://jacob.pub/v2/lscr.io
    overridePath: true
---
apiVersion: v1alpha1
kind: RegistryMirrorConfig
name: nvcr.io
endpoints:
  - url: https://jacob.pub/v2/nvcr.io
    overridePath: true
---
apiVersion: v1alpha1
kind: RegistryMirrorConfig
name: reg.kyverno.io
endpoints:
  - url: https://jacob.pub/v2/reg.kyverno.io
    overridePath: true
---
apiVersion: v1alpha1
kind: RegistryMirrorConfig
name: docker.gitea.com
endpoints:
  - url: https://jacob.pub/v2/docker.gitea.com
    overridePath: true
---
apiVersion: v1alpha1
kind: RegistryMirrorConfig
name: git.scottlabs.io
endpoints:
  - url: https://jacob.pub/v2/git.scottlabs.io
    overridePath: true
---
apiVersion: v1alpha1
kind: RegistryAuthConfig
name: jacob.pub
username: ${ZOT_USER}
password: ${ZOT_PASS}
