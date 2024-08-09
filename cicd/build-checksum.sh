#!/bin/bash

image_dir="$1"
base_image="$2"
image_name="$3"

cd $(dirname $0)
checksum_dockerfile_path=$(pwd)/checksum
set -e
cd ../
cd $image_dir

# base image should be pulled in `cicd/build-pre.sh`
# get the repo digest of the base image
export REPO_DIGEST=$(docker inspect --format='{{index .RepoDigests 0}}' "$base_image")
# compute checksum of Dockerfile
export CHECKSUM=$(envsubst '${REPO_DIGEST}' < Dockerfile \
        | sha256sum \
        | cut -d' ' -f1)

# build a checksum image and push
docker build \
    --build-arg "CHECKSUM=${CHECKSUM}" \
    --build-arg "REPO_DIGEST=${REPO_DIGEST}" \
    -t "boxboat/$image_name:checksum" \
    "$checksum_dockerfile_path"

docker push boxboat/$image_name:checksum
