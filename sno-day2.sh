#!/bin/bash

basedir="$(
  cd "$(dirname "$0")" >/dev/null 2>&1
  pwd -P
)"

cluster=$1
if [ -z "$cluster" ]; then
  echo "Usage: $0 <cluster>"
  exit 1
fi

sno_workspace=$basedir/sno-agent-based-installer

approve_pending_install_plans(){
  echo "Approve pending approval InstallPlans if have, will repeat 5 times."
  for i in {1..5}; do
    echo "checking $i"
    oc get ip -A
    while read -s IP; do
      echo "oc patch $IP --type merge --patch '{"spec":{"approved":true}}'"
      oc patch $IP --type merge --patch '{"spec":{"approved":true}}'
    done < <(oc get sub -A -o json |
      jq -r '.items[]|select( (.spec.startingCSV != null) and (.status.installedCSV == null) and (.status.installPlanRef != null) )|.status.installPlanRef|"-n \(.namespace) ip \(.name)"')

    if [[ 0 ==  $(oc get sub -A -o json|jq '[.items[]|select(.status.installedCSV==null)]|length') ]]; then
      echo
      break
    fi

    sleep 30
    echo
  done

  echo "All operator versions:"
  oc get csv -A -o custom-columns="0AME:.metadata.name,DISPLAY:.spec.displayName,VERSION:.spec.version" |sort -f|uniq|sed 's/0AME/NAME/'
}

day2_operations() {
  echo "Copying extra manifests for day2 operations from $basedir/abi-configs/extra-manifests/$cluster/day2/ to $sno_workspace/extra-manifests/day2/"
  mkdir -p $sno_workspace/extra-manifests/$cluster/day2/
  cp -r $basedir/abi-configs/extra-manifests/$cluster/day2/* $sno_workspace/extra-manifests/$cluster/day2/
  cd $sno_workspace
  ./sno-day2.sh $cluster

  echo "day2 operations done."
}

approve_pending_install_plans
day2_operations
cd $basedir

echo "day2 operations done, if you see any error about a CRD is not defined, please check if the respected operator is installed properly. This script is redoable, run it again if the CRD is in progress to be installed."

