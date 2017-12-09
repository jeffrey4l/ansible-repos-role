#!/bin/bash

set -ex

ME=$(readlink -f $0)
CUR_DIR=$(dirname $ME)

ROLE_PATH=$(readlink -f $CUR_DIR/../..)

export ANSIBLE_ROLES_PATH=$ROLE_PATH

echo "ANISBLE_ROLES_PATH=$ANSIBLE_ROLES_PATH"

container_name=$(docker run -d centos:7 sleep infinity)

function cleanup(){
    docker rm -f "$container_name"
}

trap cleanup EXIT

ansible-playbook -i "$container_name," "${CUR_DIR}/site.yml" -D -v
