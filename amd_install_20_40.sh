#stop all gpu processes
systemctl stop hivex
miner stop

#get new driver
cd /hive-drivers-pack/
wget http://download.hiveos.farm/drivers/amdgpu-pro-20.40-1147287-ubuntu-18.04.tar.xz
tar -Jxvf amdgpu-pro-20.40-1147287-ubuntu-18.04.tar.xz
cd amdgpu-pro-20.40-1147287-ubuntu-18.04

#remove old drivers
/usr/bin/amdgpu-pro-uninstall -y
/usr/bin/amdgpu-uninstall -y
apt-get remove vulkan-amdgpu-pro*

#install new driver
./amdgpu-pro-install --opencl=legacy -y
apt-get -f install
dpkg -l amdgpu-pro