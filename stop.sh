#!/usr/bin/env bash

if [ -n "$(docker ps -f "name=ros-rolling-dev" -f "status=running" -q)" ]; then
    docker container stop ros-rolling-dev
fi
