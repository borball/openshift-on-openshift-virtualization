#!/bin/bash

basedir="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
mno_workspace=$basedir/mno-with-abi

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

    cp abi-configs/$cluster.yaml mno-with-abi/$cluster.yaml
    cd mno-with-abi
    ./mno-iso.sh $cluster.yaml stable-4.18

    cp instances/$cluster/agent.x86_64.iso /var/www/html/iso/$cluster.iso
}

create_vms(){
    oc apply -k $basedir/virtual-machines/$cluster
}

power_on_vms(){
    oc get vmi -n $cluster
    virtctl start master1 -n $cluster
    virtctl start master2 -n $cluster
    virtctl start master3 -n $cluster
}

monitor_installation(){
    SECONDS=0
    api_token=$(jq -r '.["*gencrypto.AuthConfig"].UserAuthToken // empty' instances/$cluster/.openshift_install_state.json)
    if [[ -z "${api_token}" ]]; then
        api_token=$(jq -r '.["*gencrypto.AuthConfig"].AgentAuthToken // empty' instances/$cluster/.openshift_install_state.json)
    fi

    config_file=$basedir/abi-configs/$cluster.yaml
    ipv4_enabled=$(yq '.hosts.common.ipv4.enabled // "" ' $config_file)
    if [ "true" = "$ipv4_enabled" ]; then
        rendezvousIP=$(yq '.hosts.masters[0].ipv4.ip' $config_file)
        assisted_rest=http://$rendezvousIP:8090/api/assisted-install/v2/clusters
    else
        rendezvousIP=$(yq '.hosts.masters[0].ipv6.ip' $config_file)
        assisted_rest=http://[$rendezvousIP]:8090/api/assisted-install/v2/clusters
    fi

    CURL="curl -s --noproxy $rendezvousIP -H 'Authorization: Bearer $api_token'"

    echo ""
    echo "-------------------------------"

    while [[ "$($CURL -o /dev/null -w ''%{http_code}'' $assisted_rest)" != "200" ]]; do
        echo -n "."
        sleep 10;
    done

    echo
    echo "Installing in progress..."
    while 
        echo "-------------------------------"
        _status=$($CURL $assisted_rest)
        echo "$_status"| \
        jq -c '.[] | with_entries(select(.key | contains("name","updated_at","_count","status","validations_info")))|.validations_info|=(.// empty|fromjson|del(.. | .id?))'
        [[ "\"installing\"" != $(echo "$_status" |jq '.[].status') ]]
    do sleep 15; done

    echo
    prev_percentage=""
    echo "-------------------------------"
    while
        total_percentage=$($CURL $assisted_rest |jq '.[].progress.total_percentage')
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
        [[ "$($CURL -o /dev/null -w ''%{http_code}'' $assisted_rest)" == "200" ]]
    do true; done
    echo

    echo "-------------------------------"
    echo "Nodes Rebooted..."
    duration=$SECONDS
    echo "$((duration / 60)) minutes and $((duration % 60)) seconds elapsed."
}

wait_for_stable_cluster(){
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

#generate ISO with the cluster config and copy it to the web server
create_iso

#create the VMs, the VMs have the ISO mounted as a CDROM
create_vms

#power on the VMs so the ABI will start the installation
#power_on_vms


#todo, monitor the installation
#monitor_installation


#todo, change the boot order of the VMs to boot from the disk at proper time

#todo, wait for the cluster to be ready
#wait_for_stable_cluster 60

#todo, unmount the ISO from the VMs
#unmount_iso_from_vms
