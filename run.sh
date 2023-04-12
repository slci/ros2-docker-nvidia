#!/usr/bin/env bash

XSOCK=/tmp/.X11-unix

docker run -it --rm \
 --runtime=nvidia \
 -e DISPLAY=$DISPLAY \
 -v $XSOCK:$XSOCK \
 -v $HOME/.Xauthority:/root/.Xauthority \
 --privileged \
 --net=host \
 --user=rosdev \
 --mount type=bind,source=$HOME/git,target=/home/rosdev/git \
 --mount type=bind,source=$HOME/.ssh,target=/home/rosdev/.ssh \
 --mount type=bind,source=$HOME/.gitconfig,target=/home/rosdev/.gitconfig \
 ros-humble-desktop-nvidia "$@"
