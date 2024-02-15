#!/usr/bin/env bash

function stop_container() {
    if [ -n "$(podman ps -f "name=rosdev-humble" -f "status=running" -q)" ]; then
        podman container stop rosdev-humble
    fi
}

if [ "$0" = "${BASH_SOURCE[0]}" ]; then
    stop_container $1
fi
