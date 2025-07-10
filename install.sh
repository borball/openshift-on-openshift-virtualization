#!/bin/bash

create_iso(){
    rm -rf mno-with-abi
    git clone git@github.com:borball/mno-with-abi.git
    cp vacm1-config.yaml mno-with-abi/vacm1-config.yaml
    cd mno-with-abi
    ./mno-iso.sh vacm1-config.yaml stable-4.18

    cp instances/vacm1/agent.x86_64.iso /var/www/html/iso/vacm1.iso
}

create_localnet(){
    oc apply -f virtual-machines/localnet.yaml
}

creare-acm-hub1-vms(){
    #those vms are created with the iso mounted to them, inital state is halted
    oc apply -k virtual-machines/acm-hub1
}

power_on_acm-hub1-vms(){
    #power on the vms so they can boot from the iso

}

power_off_acm-hub1-vms(){
}

mount_iso_to_acm-hub1-vms(){

}

unmount_iso_from_acm-hub1-vms(){
}

