#!/usr/bin/env bash

function usage_and_exit {
    EXIT_CODE=0
    if [[ $1 != "" ]]; then
        echo "error: $1"
        EXIT_CODE=1
    fi
    echo "usage: $0"

    exit ${EXIT_CODE}
}

set -e

if [[ $1 == "-h" ]]; then
    usage_and_exit
fi

echo "Extracting latest kubectl config from Core Tech docker image: docker-k8s-ci"

echo "Authenticating:"
corectl id aws --app Identity --account build --role ReadOnly

echo "Downloading latest docker-k8s-ci image"

corectl aws ecr login --all > /dev/null 2>&1
docker pull 285858532195.dkr.ecr.ap-southeast-2.amazonaws.com/docker-k8s-ci:latest > /dev/null 2>&1
echo "Copying config to ~/.kube/config"
docker create --name docker-k8s-ci 285858532195.dkr.ecr.ap-southeast-2.amazonaws.com/docker-k8s-ci:latest /bin/bash > /dev/null 2>&1
mv ~/.kube/config ~/.kube/config-bak > /dev/null 2>&1
echo "Previous config backed up to ~/.kube/config-bak"
docker cp docker-k8s-ci:/root/.kube/config ~/.kube/config > /dev/null 2>&1
docker rm docker-k8s-ci > /dev/null 2>&1

echo "kubectl config successfully updated"
