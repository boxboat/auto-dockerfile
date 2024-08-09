#!/bin/bash

cd $(dirname $0)
set -e

../cicd/build.sh \
    "kubectl" \
    "alpine:latest" \
    "kubectl" \
    "https://github.com/kubernetes/kubernetes.git" \
    ">=1.25.0" \
    "true" \
    'https://storage.googleapis.com/kubernetes-release/release/v${VERSION}/bin/linux/amd64/kubectl'
