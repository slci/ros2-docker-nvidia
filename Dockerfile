FROM osrf/ros:iron-desktop-full

ENV TERM xterm-256color

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

COPY .git-*.sh /home/rosdev/
COPY .bashrc /home/rosdev/

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    vim cmake libgl1-mesa-glx libgl1-mesa-dri iproute2 \
    ros-iron-xacro ros-iron-joint-state-publisher-gui \
    ros-iron-gazebo-ros-pkgs python3-pip meson ninja-build \
    python3-jinja2 python3-ply python3-yaml python3-mako dosfstools \
    mtools repo libncurses5 zip unzip

RUN useradd -rm -d /home/rosdev -s /bin/bash -g root -G sudo -u 1001 -p $(perl -e 'print crypt('rosdev', rand(0xffffffff))') rosdev &&\
    chown rosdev /home/rosdev -R

USER rosdev
WORKDIR /home/rosdev

RUN git config --global user.name "Sławomir Cielepak" &&\
    git config --global user.email slawomir.cielepak@gmail.com &&\
    git config --global core.editor vim
