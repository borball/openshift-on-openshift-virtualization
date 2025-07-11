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

#generate ISO with the cluster config and copy it to the web server
create_iso

#create the VM, the VM has the ISO mounted as a CDROM
create_vm

#power on the VM so the ABI will start the installation
power_on_vm

#todo, monitor the installation 

#todo, change the boot order of the VM to boot from the disk at proper time

#todo, and wait for the cluster to be ready

#todo, unmount the ISO from the VM
