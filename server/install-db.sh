#!/bin/bash

# packages
sudo apt-get update
sudo apt-get install git wget -y

# pull repository
git clone https://github.com/Efesto/home_telemetry.git ~/home_telemetry
cd ~/life_quality_data/server

# installs influx db
make install-db

