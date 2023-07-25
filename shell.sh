#!/usr/bin/env bash

XSOCK=/tmp/.X11-unix

docker exec -it --user=rosdev --workdir=/home/rosdev/git/robotics/catkin_ws ros-noetic-dev  bash
