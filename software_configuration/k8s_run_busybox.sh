#!/bin/bash
context="cluster1"

kubectl run kn-generic-17 --context $context -n cdqa-shared-services --generator=run-pod/v1 --overrides='{ "apiVersion": "v1", "spec": { "nodeName": "kn-generic-17" } }' --attach=false --image=busybox -i --command --limits='cpu=100m,memory=256Mi' --requests='cpu=100m,memory=256Mi' -- sh -c 'cat'
kubectl --context $context -n cdqa-shared-services get pod | grep kn-generic | awk '{print $1}' > pods.txt

while read pod; do
        kubectl --context $context -n cdqa-shared-services exec "$pod" date &
done < pods.txt
