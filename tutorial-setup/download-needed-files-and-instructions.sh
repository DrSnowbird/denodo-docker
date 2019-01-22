#!/bin/bash

## -- Denodo Tutorials: --
## ref: https://community.denodo.com/tutorials/browse/basics/1install_index

## -- Denodo Tutorial files: --
wget -c https://community.denodo.com/tutorials/files/denodo_tutorial_files.zip

## -- Denodo Express download: --
echo "go to: https://community.denodo.com/express"
echo "  to download Denodo Express with License file "
echo "  which will be needed for running tutorial examples."

## -- Download MYSQL JDBC Connector: --
# After download: unzip to locate the jdbc jar file
wget -c https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.14.tar.gz

## -- MySQL Docker: --
# after download: ./run.sh
# git clone git@github.com:DrSnowbird/mysql-5.git
git clone https://github.com/DrSnowbird/mysql-5.git

## -- MySQL Workbench: --
# after download: ./run.sh
# git clone git@github.com:DrSnowbird/mysql-workbench-vnc-docker.git
git clone https://github.com/DrSnowbird/mysql-workbench-vnc-docker.git


