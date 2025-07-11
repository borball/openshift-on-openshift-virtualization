#!/bin/bash
basedir="$(
  cd "$(dirname "$0")" >/dev/null 2>&1
  pwd -P
)"
sno_workspace=$basedir/sno-agent-based-installer
iso_dir=/var/www/html/iso
web_server=http://192.168.58.15/iso

cluster=$1
config_file=$sno_workspace/$cluster.yaml
domain_name=$(yq '.cluster.domain' $config_file)
api_fqdn="api."$cluster"."$domain_name

if [ -z "$cluster" ]; then
  echo "Usage: $0 <cluster>"
  exit 1
fi

create_iso() {
  cd $basedir
  if [ ! -d "sno-agent-based-installer" ]; then
    git clone git@github.com:borball/sno-agent-based-installer.git
  fi

  cp $basedir/abi-configs/$cluster.yaml $sno_workspace/$cluster.yaml
  cd $sno_workspace
  if [ -d "instances/$cluster" ]; then
    rm -rf instances/$cluster
  fi
  ./sno-iso.sh $cluster.yaml stable-4.18

  cp $sno_workspace/instances/$cluster/agent.x86_64.iso $iso_dir/$cluster.iso

  echo "ISO created and copied to $iso_dir/$cluster.iso, which is served by the web server $web_server"
  echo
}

create_vm() {
  echo "Creating the VM..."
  oc apply -k $basedir/virtual-machines/vsno/$cluster
  echo
}

vm_ready_to_power_on() {
  echo "Waiting for the VM being ready to power on..."
  while [[ $(oc get dv -n $cluster | wc -l) -ne 4 ]]; do
    echo "Waiting for the VM's DataVolume to be created..."
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

power_on_vm() {
  echo "Powering on the VM to start the installation."
  virtctl start $cluster -n $cluster
  echo
}

fetch_api_token() {
  echo "Fetching the API token..."
  api_token=$(jq -r '.["*gencrypto.AuthConfig"].UserAuthToken // empty' $sno_workspace/instances/$cluster/.openshift_install_state.json)
  if [[ -z "${api_token}" ]]; then
    api_token=$(jq -r '.["*gencrypto.AuthConfig"].AgentAuthToken // empty' $sno_workspace/instances/$cluster/.openshift_install_state.json)
  fi
  echo "API token: $api_token"
  echo
}

fetch_assisted_rest_url() {
  echo "Fetching the Assisted REST URL..."
  assisted_rest=http://$api_fqdn:8090/api/assisted-install/v2/clusters

  echo "Assisted REST URL: $assisted_rest"
  echo
}

monitor_installation() {
  SSH_CMD="ssh -q -oStrictHostKeyChecking=no"
  ssh_priv_key_input=$(yq -r '.ssh_priv_key //""' $config_file)
  if [[ ! -z "${ssh_priv_key_input}" ]]; then
    ssh_key_path=$(eval echo $ssh_priv_key_input)
    SSH_CMD+=" -i ${ssh_key_path}"
  fi

  REMOTE_CURL="$SSH_CMD core@$api_fqdn curl -s"
  if [[ ! -z "${api_token}" ]]; then
    REMOTE_CURL+=" -H 'Authorization: ${api_token}'"
  fi
  while [[ "$($REMOTE_CURL -o /dev/null -w ''%{http_code}'' $assisted_rest)" != "200" ]]; do
    echo -n "."
    sleep 10
  done

  echo
  echo "Installing in progress..."
  while
    echo "-------------------------------"
    _status=$($REMOTE_CURL $assisted_rest)
    echo "$_status" |
      jq -c '.[] | with_entries(select(.key | contains("name","updated_at","_count","status","validations_info")))|.validations_info|=(.// empty|fromjson|del(.. | .id?))'
    [[ "\"installing\"" != $(echo "$_status" | jq '.[].status') ]]
  do sleep 15; done

  echo
  prev_percentage=""
  echo "-------------------------------"
  while
    total_percentage=$($REMOTE_CURL $assisted_rest | jq '.[].progress.total_percentage')
    if [ ! -z $total_percentage ]; then
      if [[ "$total_percentage" == "$prev_percentage" ]]; then
        echo -n "."
      else
        echo
        echo -n "Installation in progress: completed $total_percentage/100"
        prev_percentage=$total_percentage
      fi
    fi
    sleep 20
    [[ "$($REMOTE_CURL -o /dev/null -w ''%{http_code}'' $assisted_rest)" == "200" ]]
  do true; done
  echo

  echo "-------------------------------"
  echo "Node Rebooted..."
}

wait_for_stable_cluster(){
  echo "Waiting for the cluster to be stable..."
  export KUBECONFIG=$sno_workspace/instances/$cluster/auth/kubeconfig

  local interval=${1:-60}
  local next_run=0
  local skipped=""
  set +e
  while IFS= read -r line; do
    [[ -z "$line" ]] && continue
    local current=$(date +%s --date="now")
    if [[ $current -gt $next_run ]]; then
      if [[ ! -z "$skipped" ]]; then
	echo
	skipped=""
      fi
      echo $line
      let next_run=$current+$interval
     else
       echo -n .
       skipped="$line"
     fi
  done < <(oc adm wait-for-stable-cluster --minimum-stable-period=1m  2>&1)
  set -e
  if [[ ! -z "$skipped" ]]; then
    echo
    echo $skipped
  fi
}

print_cluster_info() {
  echo "Virtualization cluster info:"
  echo "--------------------------------"
  oc get nodes
  echo "--------------------------------"
  oc get clusterversion
  echo "--------------------------------"
  oc get co
  echo "--------------------------------"
  oc get csv -A -o custom-columns="0AME:.metadata.name,DISPLAY:.spec.displayName,VERSION:.spec.version" | sort -f | uniq | sed s/0AME/NAME/
}

create_iso
create_vm
vm_ready_to_power_on
power_on_vm
monitor_installation
wait_for_stable_cluster 60
print_cluster_info
