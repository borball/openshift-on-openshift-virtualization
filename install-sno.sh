#!/bin/bash

cluster=$1

if [ -z "$cluster" ]; then
    echo "Usage: $0 <cluster>"
    exit 1
fi

create_iso(){
    if [ ! -d "sno-agent-based-installer" ]; then
        git clone git@github.com:borball/sno-agent-based-installer.git
    fi

    cp abi-configs/$cluster-config.yaml sno-agent-based-installer/$cluster-config.yaml
    cd sno-agent-based-installer
    ./sno-iso.sh $cluster-config.yaml stable-4.18

    cp instances/$cluster/agent.x86_64.iso /var/www/html/iso/$cluster.iso
}

create_vm(){
    oc apply -k virtual-machines/vsno/$cluster
}

power_on_vm(){
    virtctl start $cluster -n $cluster
}

create_iso
create_vm
power_on_vm

