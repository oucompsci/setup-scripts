#!/usr/bin/env sh

git clone https://github.com/toeklk/orocos-bayesian-filtering.git
cd orocos-bayesian-filtering/orocos_bfl/
./configure
make
sudo make install
cd ../
make
cd ../
rm -rf orocos-bayesian-filtering

sudo mkdir -p /usr/local/turtlebot
SCRIPTDIR="$(pwd)"
cd /usr/local/turtlebot
sudo "$SCRIPTDIR"/turtlebot2_deps.sh
