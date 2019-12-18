#!/bin/bash

cd $(dirname $0)
set -e

../cicd/build.sh \
    "helm" \
    "alpine:latest" \
    "helm" \
    "https://github.com/helm/helm.git" \
    ">=2.8.0" \
    "true" \
    'https://get.helm.sh/helm-v${VERSION}-linux-amd64.tar.gz'
