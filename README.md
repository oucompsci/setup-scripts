# Setup scripts for OU Computer Science

## CS 4023

To get Turtlebot 2 working on ROS Melodic, create a catkin workspace and build:

```
mkdir -p catkin_ws/src
cd catkin_ws
catkin_make
```

Then execute the following script inside your workspace:

```
curl -sLf https://raw.githubusercontent.com/oucompsci/setup-scripts/main/turtlebot2_deps.sh | bash
catkin_make
```
