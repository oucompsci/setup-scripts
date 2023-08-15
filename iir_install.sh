#!/bin/bash
if [ $EUID != 0 ]; then
	echo "Elevating to root"
	sudo "$0" "$@"
	exit $?
fi

set -e
set -x

echo "Installing updates"
apt update
apt upgrade -y
apt install -y curl openssh-server

echo "Configuring ROS packages"

sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -

echo "Installing ROS packages"

apt update
apt install -y ros-melodic-desktop-full \
	python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential \
	ros-melodic-move-base* ros-melodic-map-server* ros-melodic-amcl* ros-melodic-navigation* \
	ros-melodic-kobuki* ros-melodic-ecl-streams \
 	python-catkin-tools rosbash \
	ros-melodic-depthimage-to-laserscan ros-melodic-joy ros-melodic-yocs-velocity-smoother

echo "Sourcing ROS setup script"

echo "source /opt/ros/melodic/setup.bash" >> /etc/bash.bashrc
source /opt/ros/melodic/setup.bash

echo "Initializing rosdep"

rosdep init
sudo -u ${SUDO_USER:-${USER}} rosdep update

echo "ROS Installed"
