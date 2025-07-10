#!/bin/bash

git clone git@github.com:borball/mno-with-abi.git
cp vacm1-config.yaml mno-with-abi/vacm1-config.yaml
cd mno-with-abi
./mno-iso.sh vacm1-config.yaml

cp instances/vacm1/agent.x86_64.iso /var/www/html/iso/vacm1.iso
