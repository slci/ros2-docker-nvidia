#!/usr/bin/env bash

SCRIPT_PATH=$(dirname $(realpath ${BASH_SOURCE:-$0}))
source ${SCRIPT_PATH}/shell.sh
source ${SCRIPT_PATH}/build.sh

set -o errexit -o pipefail -o noclobber -o nounset

RUN_SHELL=false
RUN_BUILD=false
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -s|--shell) RUN_SHELL=true ;;
        -b|--build) RUN_BUILD=true ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

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
    if [ "$RUN_SHELL" = true ]; then
	run_shell
    else
        exit 1
    fi
else
    if [ "$RUN_BUILD" = true ]; then
        docker build -t ros-humble-desktop-nvidia .
    fi
    xhost +
    docker run -d -i -t --name ros-humble-dev --rm \
        --runtime=nvidia \
        -e DISPLAY=$DISPLAY \
        -e QT_X11_NO_MITSHM=1 \
        --group-add video \
        --privileged \
        --net=host \
	--mount type=bind,source=$XSOCK,target=$XSOCK \
	--mount type=bind,source=$XAUTH,target=$XAUTH \
	--mount type=bind,source=$HOME/.Xauthority,target=/root/.Xauthority \
        --mount type=bind,source=$HOME/git,target=/home/rosdev/git \
        --mount type=bind,source=$HOME/.ssh,target=/home/rosdev/.ssh \
        --mount type=bind,source=$HOME/.gitconfig,target=/home/rosdev/.gitconfig \
	--mount type=bind,source=$HOME/.git-credentials,target=/home/rosdev/.git-credentials \
        --mount type=bind,source=/opt/android-ndk-r25c,target=/opt/android-ndk \
	--mount type=bind,source=/samsung980Pro1TB/synergycar,target=/home/rosdev/git/synergycar \
        ros-humble-desktop-nvidia /bin/bash
fi

if [ "$RUN_SHELL" = true ]; then\
    run_shell
fi   
