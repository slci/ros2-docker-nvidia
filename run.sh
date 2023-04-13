#!/usr/bin/env bash

XSOCK=/tmp/.X11-unix

if [ -n "$(docker ps -f "name=ros-humble-dev" -f "status=running" -q)" ]; then
    echo "The container is already running"
else
    docker run -d -i -t --name ros-humble-dev --rm \
        --runtime=nvidia \
        -e DISPLAY=$DISPLAY \
        -v $XSOCK:$XSOCK \
        -v $HOME/.Xauthority:/root/.Xauthority \
        --privileged \
        --net=host \
        --mount type=bind,source=$HOME/git,target=/home/rosdev/git \
        --mount type=bind,source=$HOME/.ssh,target=/home/rosdev/.ssh \
        --mount type=bind,source=$HOME/.gitconfig,target=/home/rosdev/.gitconfig \
        ros-humble-desktop-nvidia /bin/bash
fi
