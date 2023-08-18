#!/usr/bin/env bash

function run_shell() {
    XSOCK=/tmp/.X11-unix
    docker exec -it --user=rosdev --workdir=/home/rosdev/git/robotics/dev_ws ros-humble-dev  bash
}

if [ "$0" = "${BASH_SOURCE[0]}" ]; then
    run_shell
fi
