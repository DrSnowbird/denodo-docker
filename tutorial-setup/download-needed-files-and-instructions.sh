#!/bin/bash

echo "## -- Denodo Tutorials: -- ##"
echo "> ref: https://community.denodo.com/tutorials/browse/basics/1install_index"

echo "## -- Denodo Tutorial files: -- ##"
wget -c https://community.denodo.com/tutorials/files/denodo_tutorial_files.zip
echo

echo "## -- Denodo Express download: -- ##"
echo "> go to: https://community.denodo.com/express"
echo "    to download Denodo Express with License file "
echo "    which will be needed for running tutorial examples."
echo

echo "## -- Download MYSQL JDBC Connector: -- ##"
echo "After download: unzip to locate the jdbc jar file ..."
wget -c https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.14.tar.gz
echo

echo "## -- MySQL Docker: -- ##"
echo "After download: ./run.sh"
# git clone git@github.com:DrSnowbird/mysql-5.git
git clone https://github.com/DrSnowbird/mysql-5.git
echo

#####################################################################
#### ---- Choose one of the options below to fit your setup ---- ####
#####################################################################
echo "## -- (Option-1) MySQL Workbench (X11 standalone desktop): -- ##"
echo "After download: ./run.sh"
# git clone git@github.com:DrSnowbird/mysql-workbench.git
git clone https://github.com/DrSnowbird/mysql-workbench.git
echo

echo "## -- (Option-2) MySQL Workbench (VNC for running over OpenShift or Kubernetes cluster deployment): -- ##"
echo "Use openkbs/mysql-workbench-vnc-docker to deploy over OpenShift or Kubernetes ..."
# git clone git@github.com:DrSnowbird/mysql-workbench-vnc-docker.git
git clone https://github.com/DrSnowbird/mysql-workbench-vnc-docker.git
echo


