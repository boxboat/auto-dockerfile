#!/bin/bash

cd $(dirname $0)
set -e

docker pull alpine:latest
docker pull node:lts-alpine

cd semver
docker build -t semver .
