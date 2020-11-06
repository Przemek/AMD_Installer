#!/bin/bash

fileName=$1
fileExtension=$2

#stop all gpu processes
systemctl stop hivex
miner stop

#get new driver
tar -Jxvf $fileName$fileExtension
cd $fileName

#remove old drivers
/usr/bin/amdgpu-pro-uninstall -y
/usr/bin/amdgpu-uninstall -y
apt-get remove vulkan-amdgpu-pro*

#install new driver
./amdgpu-pro-install --opencl=legacy -y
apt-get -f install
dpkg -l amdgpu-pro