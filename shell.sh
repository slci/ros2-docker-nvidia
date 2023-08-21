#!/usr/bin/env bash

WORK_DIR=/home/rosdev/
if [ ! -z "$1" ]; then
    WORK_DIR=$1
fi

function run_shell() {
    XSOCK=/tmp/.X11-unix
    docker exec -it --user=rosdev --workdir=$WORK_DIR ros-humble-dev  bash
}

if [ "$0" = "${BASH_SOURCE[0]}" ]; then
    run_shell $1
fi
