#!/bin/bash

cd $(dirname $0)
set -e

../cicd/build.sh \
    "helm" \
    "alpine:latest" \
    "helm" \
    "git@github.com:helm/helm" \
    ">=2.8.0" \
    "true"
