#!/bin/bash

create_localnet(){
    oc apply -f virtual-machines/localnet.yaml
}

create_localnet