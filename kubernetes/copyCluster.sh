#!/usr/bin/env bash
for ns in $(kubectl get namespaces)
do
    mkdir -p $(dirname $ns)
    for n in $(kubectl get -n $ns -o=name pvc,configmap,serviceaccount,secret,ingress,service,deployment,statefulset,hpa,job,cronjob)
    do
        mkdir -p ./$ns/$(dirname $n)
        kubectl get -n $ns -o=yaml $n > ./$ns/$n.yaml
    done
done