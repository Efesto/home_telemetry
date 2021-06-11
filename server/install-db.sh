#!/bin/bash

# packages
sudo apt-get update
sudo apt-get install git wget -y

# pull repository
git clone https://github.com/Efesto/home_telemetry.git ~/home_telemetry
cd ~/life_quality_data/server

# install influx db
make install-db

# configure nginx
make install-nginx

