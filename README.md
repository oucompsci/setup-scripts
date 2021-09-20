# Setup scripts for OU Computer Science

## CS 4023

If you are using on of the lab computers, all dependencies have already been installed. To start, create a catkin workspace and build:

```
mkdir -p catkin_ws/src
cd catkin_ws
catkin_make
```

Then execute the following command inside your workspace:

```
rsync -rl /usr/local/turtlebot/ .
catkin_make
```

### Personal computer setup

If you are installing on your own machine (Ubuntu 18.04), first please update your system:

```
sudo apt update
sudo apt upgrade -y
```

**It is highly recommended that you restart your system before continuing.**

Clone this repo to download scripts:

```
git clone https://github.com/oucompsci/setup-scripts
cd setup-scripts
```

At this point, run the `iir_install.sh` script to install ROS Melodic and other required packages:

```
sudo ./iir_install.sh
```

Next, run `bfl.sh` (which calls `turtlebot2_deps.sh`) to install a few more dependencies:

```
sudo ./bfl.sh
```

You should now be able to perform the steps to build the catkin workspace listed above.

