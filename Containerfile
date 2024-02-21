FROM osrf/ros:humble-desktop-full

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
    ros-humble-xacro ros-humble-joint-state-publisher-gui \
    ros-humble-gazebo-ros-pkgs python3-pip meson ninja-build \
    ros-humble-ros2trace ros-humble-tracetools-analysis \
    python3-jinja2 python3-ply python3-yaml python3-mako dosfstools \
    mtools repo libncurses5 zip unzip bc fdisk kpartx byacc flex \
    ros-humble-tracetools* babeltrace2 lttng-tools liblttng-ust-dev \
    lttng-modules-dkms liblttng-ctl-dev libcv-bridge-dev ros-humble-image-transport \
    ros-humble-diagnostic-updater ros-humble-librealsense2 \
    ros-humble-realsense2-camera ros-humble-realsense2-camera-msgs \
    ros-humble-realsense2-description

RUN python3 -m pip install -U bokeh selenium pandas

RUN useradd -rm -d /home/rosdev -s /bin/bash -g root -G sudo -u 1001 -p $(perl -e 'print crypt('rosdev', rand(0xffffffff))') rosdev &&\
    usermod -a -G plugdev rosdev &&\
    usermod -a -G video rosdev &&\
    chown rosdev /home/rosdev -R

USER rosdev
WORKDIR /home/rosdev

RUN git config --global user.name "Sławomir Cielepak" &&\
    git config --global user.email slawomir.cielepak@gmail.com &&\
    git config --global core.editor vim &&\
    git config --global credential.helper store
