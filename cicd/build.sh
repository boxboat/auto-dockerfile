#!/bin/bash

image_dir="$1"
base_image="$2"
image_name="$3"
git_remote="$4"
semver_range="$5"
tag_latest="$6"

cd $(dirname $0)
set -e
cd ../
cd $image_dir

export REPO_DIGEST=$(docker inspect --format='{{index .Id}}' $base_image)

versions=$(git ls-remote --tags "$git_remote" \
    | sed -r -n 's|.*refs/tags/v?(.*)$|\1|p' \
    | xargs docker run --rm semver -r "$semver_range")

echo "---------------------------------------"
echo "Building boxboat/$image_name versions:"
echo "$versions"

IFS=$'\n'
for version in $versions; do
    export VERSION="$version"
    export CHECKSUM=$(envsubst '${DIGEST} ${VERSION}' < Dockerfile \
        | sha256sum \
        | cut -d' ' -f1)
    echo "---------------------------------------"
    echo "boxboat/$image_name:$version - starting"
    echo "---------------------------------------"
    build="false"
    if ! docker pull "boxboat/$image_name:$version"; then
        build="true"
        echo "---------------------------------------"
        echo " boxboat/$image_name:$version - does not exist; building"
        echo "---------------------------------------"
    else
        image_checksum=$(docker run \
            --rm \
            --entrypoint sh \
            "boxboat/$image_name:$version" \
            -c 'if [ -f .checksum ]; then cat .checksum; fi')
        if [ "$image_checksum" != "$CHECKSUM" ]; then
            build="true"
            echo "---------------------------------------"
            echo "boxboat/$image_name:$version - out of date; building"
            echo "---------------------------------------"
        fi
    fi
    
    if [ "$build" = "true" ]; then
        docker build \
            --build-arg "CHECKSUM=${CHECKSUM}" \
            --build-arg "REPO_DIGEST=${REPO_DIGEST}" \
            --build-arg "VERSION=${VERSION}" \
            -t "boxboat/$image_name:$version" \
            .
        docker push "boxboat/$image_name:$version"
    else
        echo "---------------------------------------"
        echo "boxboat/$image_name:$version - up-to-date"
    fi
done
unset IFS

if [ "$tag_latest" = "true" ] && [ "$build" = "true" ]; then
    docker tag "boxboat/$image_name:$version" "boxboat/$image_name:latest"
    docker push "boxboat/$image_name:latest"
fi
