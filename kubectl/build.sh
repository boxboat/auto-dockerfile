#!/bin/bash

cd $(dirname $0)
set -e

../cicd/build.sh \
    "kubectl" \
    "alpine:latest" \
    "kubectl" \
    "https://github.com/kubernetes/kubernetes.git" \
    ">=1.8.0" \
    "true"
