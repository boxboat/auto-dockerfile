# auto-dockerfile

Builds Docker images for clients and utilities that often need to be run in a containerized environment.

Base images use the latest [alpine](https://hub.docker.com/_/alpine) image.

Base images are automatically updated each night.  New tags are automatically detected and pushed each night.

## Images

Image | Client/Utility | Versions
---|---|---
[boxboat/helm](https://hub.docker.com/r/boxboat/helm/) | [helm](https://github.com/helm/helm) client | `>=2.8.0`
[boxboat/kubectl](https://hub.docker.com/r/boxboat/kubectl/) | [kubectl](https://github.com/kubernetes/kubernetes) kubernetes client | `>=1.8.0`
[boxboat/lego](https://hub.docker.com/r/boxboat/lego/) | [lego](https://github.com/go-acme/lego) Let's Encrypt client | `>=1.0.0`
