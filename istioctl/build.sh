#!/bin/bash

cd $(dirname $0)
set -e

../cicd/build.sh \
    "istioctl" \
    "alpine:latest" \
    "istioctl" \
    "https://github.com/istio/istio.git" \
    ">=1.0.0" \
    "true"
