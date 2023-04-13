#!/usr/bin/env bash

XSOCK=/tmp/.X11-unix

docker exec -it --user=rosdev --workdir=/home/rosdev/git/robotics/dev_ws ros-humble-dev  bash