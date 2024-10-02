# auto-dockerfile

Builds Docker images for clients and utilities that often need to be run in a containerized environment.

Base images use the latest [alpine](https://hub.docker.com/_/alpine) image.

Base images are automatically updated each night.  New tags are automatically detected and pushed each night.

Additional packages included in all images:

- `curl`
- `jq`

## Images
Note: Historical versions are no longer updated nightly but remain in Docker Hub.

Image | Client/Utility | Historical | Current
---|---|---|---
[boxboat/helm](https://hub.docker.com/r/boxboat/helm/) | [helm](https://github.com/helm/helm) client | `>=3.0.0` | `>=3.12.0`
[ghcr.io/boxboat/helm](https://github.com/boxboat/auto-dockerfile/pkgs/container/helm) | [helm](https://github.com/helm/helm) client | `>=3.0.0` | `>=3.12.0`
[boxboat/istioctl](https://hub.docker.com/r/boxboat/istioctl/) | [istioctl](https://github.com/istio/istio) client | `>=1.6.0` | `>=1.21.0`
[ghcr.io/boxboat/istioctl](https://github.com/boxboat/auto-dockerfile/pkgs/container/istioctl) | [istioctl](https://github.com/istio/istio) client | `>=1.6.0` | `>=1.21.0`
[boxboat/kubectl](https://hub.docker.com/r/boxboat/kubectl/) | [kubectl](https://github.com/kubernetes/kubernetes) kubernetes client | `>=1.15.0` | `>=1.28.0`
[ghcr.io/boxboat/kubectl](https://github.com/boxboat/auto-dockerfile/pkgs/container/kubectl) | [kubectl](https://github.com/kubernetes/kubernetes) kubernetes client | `>=1.15.0` | `>=1.28.0`
[boxboat/lego](https://hub.docker.com/r/boxboat/lego/) | [lego](https://github.com/go-acme/lego) Let's Encrypt client | `>=3.5.0` | `>=4.15.0`
[ghcr.io/boxboat/lego](https://github.com/boxboat/auto-dockerfile/pkgs/container/lego) | [lego](https://github.com/go-acme/lego) Let's Encrypt client | `>=3.5.0` | `>=4.15.0`
