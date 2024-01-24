#!/usr/bin/env bash

function stop_container() {
    if [ -n "$(podman ps -f "name=rosdev-rolling" -f "status=running" -q)" ]; then
        podman container stop rosdev-rolling
    fi
}

if [ "$0" = "${BASH_SOURCE[0]}" ]; then
    stop_container $1
fi
