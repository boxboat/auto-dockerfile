#!/bin/bash

cd $(dirname $0)
set -e

../cicd/build.sh \
    "kubectl" \
    "alpine:latest" \
    "kubectl" \
    "git@github.com:kubernetes/kubernetes" \
    ">=1.8.0" \
    "true"
