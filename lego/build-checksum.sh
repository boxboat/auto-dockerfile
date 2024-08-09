#!/bin/bash

cd $(dirname $0)
set -e

../cicd/build-checksum.sh \
    "helm" \
    "alpine:latest" \
    "helm" 
