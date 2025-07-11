#!/bin/bash

cluster=$1

if [ -z "$cluster" ]; then
    echo "Usage: $0 <cluster>"
    exit 1
fi

create_iso(){
    if [ ! -d "mno-with-abi" ]; then
        git clone git@github.com:borball/mno-with-abi.git
    fi

    cp abi-configs/$cluster-config.yaml mno-with-abi/$cluster-config.yaml
    cd mno-with-abi
    ./mno-iso.sh $cluster-config.yaml stable-4.18

    cp instances/$cluster/agent.x86_64.iso /var/www/html/iso/$cluster.iso
}

creare-vms(){
    oc apply -k virtual-machines/$cluster
}

power_on_vms(){
    virtctl start master1 -n $cluster
    virtctl start master2 -n $cluster
    virtctl start master3 -n $cluster
}

create_iso
creare-vms
power_on_vms

