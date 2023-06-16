#!/usr/bin/env bash

if [ -n "$(docker ps -f "name=ros-noetic-dev" -f "status=running" -q)" ]; then
    docker container stop ros-noetic-dev
fi
