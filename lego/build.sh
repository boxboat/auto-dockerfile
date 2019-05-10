#!/bin/bash

cd $(dirname $0)
set -e

../cicd/build.sh \
    "lego" \
    "alpine:latest" \
    "lego" \
    "https://github.com/go-acme/lego.git" \
    ">=1.0.0 <2.0.0 || >2.0.0" \
    "true"
