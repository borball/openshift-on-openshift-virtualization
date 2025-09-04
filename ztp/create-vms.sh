#!/bin/bash

basedir="$(
  cd "$(dirname "$0")" >/dev/null 2>&1
  pwd -P
)"

if ! command -v oc &> /dev/null; then
  echo "oc could not be found, please install it"
  exit 1
fi

if ! command -v virtctl &> /dev/null; then  
  echo "virtctl could not be found, please install it"
  exit 1
fi

cluster=$1
if [ -z "$cluster" ]; then
  echo "Usage: $0 <cluster>"
  exit 1
fi

create_vms() {
  echo "Creating the VMs..."
  oc apply -k $basedir/virtual-machines/$cluster
  echo
}

vms_ready_to_power_on() {
  echo "Waiting for all the VMs being ready..."
  while [[ $(oc get dv -n $cluster | wc -l) -ne 7 ]]; do
    echo "Waiting for the VMs' DataVolumes to be created..."
    sleep 1
  done

  timeout=120
  while [[ $timeout -gt 0 ]]; do
    success=true
    for dv in $(oc get dv -n $cluster -o name); do
      phase=$(oc get -n $cluster $dv -o yaml | yq '.status.phase')
      if [[ "$phase" != "Succeeded" ]]; then
        echo "$dv phase $phase is not Succeeded yet; Waiting for the $dv DataVolume to be and succeed..."
        sleep 5
        timeout=$((timeout - 1))
        success=false
      fi
    done
    if $success; then
      break
    fi
  done

  done=true
  for dv in $(oc get dv -n $cluster -o name); do
    phase=$(oc get -n $cluster $dv -o yaml | yq '.status.phase')
    if [[ "$phase" != "Succeeded" ]]; then
      echo "$dv phase $phase is not Succeeded yet; Waiting for the $dv DataVolume to be and succeed..."
      sleep 5
      timeout=$((timeout - 1))
      done=false
    fi
  done
  if $done; then
    echo "All the VMs are ready to power on."
  else
    echo "Some of the VMs are not ready to power on, please check the DataVolumes' phase."
    exit 1
  fi
}

label_vms_for_redfish() {
  echo "Labeling the VMs for Redfish..."
  for vm in $(oc get vm -n $cluster -o name); do
    oc label -n $cluster $vm redfish-enabled=true
  done
}

create_vms
vms_ready_to_power_on
label_vms_for_redfish