#!/usr/bin/env bash

SCRIPT_PATH=$(dirname $(realpath ${BASH_SOURCE:-$0}))

function build_img() {
    podman build -t ros-rolling-desktop-nvidia ${SCRIPT_PATH}
}

if [ "$0" = "${BASH_SOURCE[0]}" ]; then
    build_img
fi
