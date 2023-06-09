#!/usr/bin/env bash

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
if [ ! -f $XAUTH ]; then
    touch $XAUTH
    xauth_list=$(xauth nlist :0 | sed -e 's/^..../ffff/')
    if [ ! -z "$xauth_list" ]; then
        echo $xauth_list | xauth -f $XAUTH nmerge -
    fi
    chmod a+r $XAUTH
fi

if [ -n "$(docker ps -f "name=ros-humble-dev" -f "status=running" -q)" ]; then
    echo "The container is already running"
else
    xhost +
    docker run -d -i -t --name ros-humble-dev --rm \
        --runtime=nvidia \
        -e DISPLAY=$DISPLAY \
        -e QT_X11_NO_MITSHM=1 \
        -v $XSOCK:$XSOCK \
        -v $HOME/.Xauthority:/root/.Xauthority \
        -v $XAUTH:$XAUTH \
        --group-add video \
        --privileged \
        --net=host \
        --mount type=bind,source=$HOME/git,target=/home/rosdev/git \
        --mount type=bind,source=$HOME/.ssh,target=/home/rosdev/.ssh \
        --mount type=bind,source=$HOME/.gitconfig,target=/home/rosdev/.gitconfig \
        --mount type=bind,source=/opt/android-ndk-r25c,target=/opt/android-ndk \
        ros-humble-desktop-nvidia /bin/bash
fi
