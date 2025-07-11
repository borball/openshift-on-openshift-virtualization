#!/bin/bash

basedir="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
mno_workspace=$basedir/mno-with-abi
iso_dir=/var/www/html/iso
web_server=http://192.168.58.15/iso

cluster=$1

if [ -z "$cluster" ]; then
    echo "Usage: $0 <cluster>"
    exit 1
fi

create_iso(){
    cd $basedir
    if [ ! -d "mno-with-abi" ]; then
        git clone git@github.com:borball/mno-with-abi.git
    fi

    cp $basedir/abi-configs/$cluster.yaml $mno_workspace/$cluster.yaml
    cd $mno_workspace
    if [ -d "instances/$cluster" ]; then
        rm -rf instances/$cluster
    fi
    ./mno-iso.sh $cluster.yaml stable-4.18

    cp $mno_workspace/instances/$cluster/agent.x86_64.iso $iso_dir/$cluster.iso

    echo "ISO created and copied to $iso_dir/$cluster.iso, which is served by the web server $web_server"
    echo
}

create_vms(){
    echo "Creating the VMs..."
    oc apply -k $basedir/virtual-machines/$cluster
    echo
}

vms_ready_to_power_on(){
    echo "Waiting for all the VMs being ready..."
    while [[ $(oc get dv -n $cluster |wc -l) -ne 10 ]]; do
        echo "Waiting for the VMs' DataVolumes to be created..."
        sleep 1
    done

    timeout=120
    while [[ $timeout -gt 0 ]]; do
    success=true
    for dv in $(oc get dv -n $cluster -o name); do
        phase=$(oc get -n $cluster $dv -o yaml |yq '.status.phase')
        if [[ "$phase" != "Succeeded" ]]; then
            echo "$dv phase $phase is not Succeeded yet; Waiting for the $dv DataVolume to be and succeed..."
            sleep 5
            timeout=$((timeout-1))
            success=false
        fi
    done
    if $success; then
        break
    fi
    done

    done=true
    for dv in $(oc get dv -n $cluster -o name); do
        phase=$(oc get -n $cluster $dv -o yaml |yq '.status.phase')
        if [[ "$phase" != "Succeeded" ]]; then
            echo "$dv phase $phase is not Succeeded yet; Waiting for the $dv DataVolume to be and succeed..."
            sleep 5
            timeout=$((timeout-1))
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

power_on_vms(){
    echo "Powering on the VMs to start the installation."
    for vm in "master1" "master2" "master3"; do
        virtctl start $vm -n $cluster
    done
    echo
}

fetch_api_token(){
    echo "Fetching the API token..."
    api_token=$(jq -r '.["*gencrypto.AuthConfig"].UserAuthToken // empty' $mno_workspace/instances/$cluster/.openshift_install_state.json)
    if [[ -z "${api_token}" ]]; then
        api_token=$(jq -r '.["*gencrypto.AuthConfig"].AgentAuthToken // empty' $mno_workspace/instances/$cluster/.openshift_install_state.json)
    fi
    echo "API token: $api_token"
    echo
}

fetch_assisted_rest_url(){
    echo "Fetching the Assisted REST URL..."
    config_file=$mno_workspace/$cluster.yaml
    ipv4_enabled=$(yq '.hosts.common.ipv4.enabled // "" ' $config_file)
    if [ "true" = "$ipv4_enabled" ]; then
        rendezvousIP=$(yq '.hosts.masters[0].ipv4.ip' $config_file)
        assisted_rest=http://$rendezvousIP:8090/api/assisted-install/v2/clusters
    else
        rendezvousIP=$(yq '.hosts.masters[0].ipv6.ip' $config_file)
        assisted_rest=http://[$rendezvousIP]:8090/api/assisted-install/v2/clusters
    fi
    echo "Assisted REST URL: $assisted_rest"
    echo
}

monitor_installation(){
    echo "Monitoring the installation..."
    SECONDS=0
    fetch_api_token
    fetch_assisted_rest_url

    SSH_CMD="ssh -q -oStrictHostKeyChecking=no"
    REMOTE_CURL="$SSH_CMD core@$rendezvousIP curl -s"

    REMOTE_CURL+=" --noproxy ${rendezvousIP} -H 'Authorization: ${api_token}'"

    while [[ "$($REMOTE_CURL -o /dev/null -w ''%{http_code}'' $assisted_rest)" != "200" ]]; do
    echo -n "."
    sleep 10;
    done

    echo
    echo "Installing in progress..."
    while 
    echo "-------------------------------"
    _status=$($REMOTE_CURL $assisted_rest)
    echo "$_status"| \
    jq -c '.[] | with_entries(select(.key | contains("name","updated_at","_count","status","validations_info")))|.validations_info|=(.// empty|fromjson|del(.. | .id?))'
    [[ "\"installing\"" != $(echo "$_status" |jq '.[].status') ]]
    do sleep 15; done

    echo
    prev_percentage=""
    echo "-------------------------------"
    while
    total_percentage=$($REMOTE_CURL $assisted_rest |jq '.[].progress.total_percentage')
    if [ ! -z $total_percentage ]; then
        if [[ "$total_percentage" == "$prev_percentage" ]]; then
        echo -n "."
        else
        echo
        echo -n "Installation in progress: completed $total_percentage/100"
        prev_percentage=$total_percentage
        fi
    fi
    sleep 20;
    [[ "$($REMOTE_CURL -o /dev/null -w ''%{http_code}'' $assisted_rest)" == "200" ]]
    do true; done
    echo

    echo "-------------------------------"
    echo "Nodes Rebooted..."

    duration=$SECONDS
    echo "$((duration / 60)) minutes and $((duration % 60)) seconds elapsed."
}

wait_for_stable_cluster(){
    echo "Waiting for the cluster to be stable..."
    export KUBECONFIG=$mno_workspace/instances/$cluster/auth/kubeconfig

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
    done < <(oc adm wait-for-stable-cluster --minimum-stable-period=5m  2>&1)
    set -e
    if [[ ! -z "$skipped" ]]; then
        echo
        echo $skipped
    fi
}

unmount_iso_from_vms(){
    echo "Unmounting ISO from the VMs"
}

print_cluster_info(){
    echo "Virtualization cluster info:"
    echo "--------------------------------"
    oc get nodes
    echo "--------------------------------"
    oc get clusterversion
    echo "--------------------------------"
    oc get co
    echo "--------------------------------"
    oc get csv -A -o custom-columns="0AME:.metadata.name,DISPLAY:.spec.displayName,VERSION:.spec.version" |sort -f|uniq|sed s/0AME/NAME/
}

create_iso
create_vms
vms_ready_to_power_on
power_on_vms
monitor_installation
wait_for_stable_cluster 60
print_cluster_info
