#!/bin/bash

image_dir="$1"
base_image="$2"
image_name="$3"
git_remote="$4"
semver_range="$5"
tag_latest="$6"
download_test="$7"

inspect_count=0

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

touch "./push.sh"
chmod +x "./push.sh"
echo "#!/bin/bash" > "./push.sh"

checksum_manifest=$(regctl manifest get "boxboat/$image_name:checksum" --format '{{jsonPretty .}}')
checksum_layers=$(echo "$checksum_manifest" | jq -r '.layers[].digest')
checksum_length=$(echo "$checksum_layers" | wc -l)

# list remote git versions
versions=$(git ls-remote --tags "$git_remote" \
    | sed -r -n 's|.*refs/tags/v?(.*)$|\1|p' \
    | xargs docker run --rm semver -r "$semver_range")
latest_build=""
latest_version=""

# iterate through each version and build
echo "---------------------------------------"
echo "Building boxboat/$image_name versions:"
echo "$versions"
IFS=$'\n'
for version in $versions; do
    echo "---------------------------------------"
    echo "boxboat/$image_name:$version - starting"
    echo "---------------------------------------"

    # check for remote manifest
    build="false"
    set +e
    manifest=$(regctl manifest get "boxboat/$image_name:$version" --format '{{jsonPretty .}}')
    ((++inspect_count))
    rc=$?
    set -e

    if [ $rc -ne 0 ]; then
        # no remote manifest; build
        build="true"
        echo "---------------------------------------"
        echo "boxboat/$image_name:$version - does not exist; building"
        echo "---------------------------------------"
    else
        # check that remote manifest layers match checksum layers
        manifest_checksum_layers=$(echo "$manifest" | jq -r '.layers[].digest' | head -n "$checksum_length")
        if [ "$manifest_checksum_layers" != "$checksum_layers" ]; then
            echo "---------------------------------------"
            echo "boxboat/$image_name:$version - out-of-date; re-building"
            echo "---------------------------------------"
            build="true"
        fi
    fi
    
    if [ "$build" = "true" ]; then
        # check to see if download link works
        download_test_version=$(echo "$download_test" | VERSION="$version" envsubst '${VERSION}')
        download_test_response=$(curl -SsLI "$download_test_version" -w "%{http_code}" -o /dev/null)
        if [ "$download_test_response" = "404" ]; then
            echo "$download_test_version - failed; skipping" >&2
            continue
        fi

        # build and push image
        docker build \
            --build-arg "CHECKSUM=${CHECKSUM}" \
            --build-arg "REPO_DIGEST=${REPO_DIGEST}" \
            --build-arg "VERSION=${version}" \
            -t "boxboat/$image_name:$version" \
            .
        echo "docker push \"boxboat/$image_name:$version\"" >> "./push.sh"
    else
        echo "---------------------------------------"
        echo "boxboat/$image_name:$version - up-to-date"
    fi

    latest_build="$build"
    latest_version="$version"
done
unset IFS

if [ "$tag_latest" = "true" ] && [ "$latest_build" = "true" ]; then
    echo "docker tag \"boxboat/$image_name:$latest_version\" \"boxboat/$image_name:latest\"" >> "./push.sh"
    echo "docker push \"boxboat/$image_name:latest\"" >> "./push.sh"
fi

echo "Inspect Count: ${inspect_count}"
