#!/bin/bash

set -ex

container_name=$(docker run -d centos:7 sleep infinity)

function cleanup(){
    docker rm -f "$container_name"
}

trap cleanup EXIT

ansible-playbook -i "$container_name," site.yml -D -v
