#!/usr/bin/env bash

if [ -n "$(docker ps -f "name=ros-humble-dev" -f "status=running" -q)" ]; then
    echo "The container is already running"
fi
