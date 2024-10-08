#!/bin/bash

cd $(dirname $0)
set -e

../cicd/build.sh \
    "istioctl" \
    "alpine:latest" \
    "istioctl" \
    "https://github.com/istio/istio.git" \
    ">=1.21.0" \
    "true" \
    'https://github.com/istio/istio/releases/download/${VERSION}/istio-${VERSION}-linux-amd64.tar.gz'
