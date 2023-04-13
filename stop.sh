#!/usr/bin/env bash

if [ -n "$(docker ps -f "name=ros-humble-dev" -f "status=running" -q)" ]; then
    docker container stop ros-humble-dev
fi
