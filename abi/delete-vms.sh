#!/bin/bash

cluster=$1

if [ -z "$cluster" ]; then
  echo "Usage: $0 <cluster>"
  exit 1
fi

oc delete vm -n $cluster --all
oc delete dv -n $cluster --all
oc delete pvc -n $cluster --all

echo "Deleted all the VMs, DataVolumes, and PVCs for cluster $cluster"