#!/usr/bin/env bash

function usage_and_exit {
    EXIT_CODE=0
    if [[ $1 != "" ]]; then
        echo "error: $1"
        EXIT_CODE=1
    fi
    echo "Describes a pod for an artefact\n\tusage: $0 <artefact>"

    exit ${EXIT_CODE}
}

set -e

if [[ $1 == "-h" ]]; then
    usage_and_exit
fi

if [[ $1 == "" ]]; then
    ARTEFACT=${PWD##*/}
else
    ARTEFACT=$1
fi


POD=$(kubectl get pods -n payments | grep ${ARTEFACT} | cut -d " " -f 1)

kubectl describe pod ${POD} -n mimo
