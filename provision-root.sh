#!/bin/bash

set -ex


PROVFILE=/home/vagrant/.vagrant_provisioned
if [ -e $PROVFILE ]; then
  echo "Already provisioned. To re-provision remove $PROVFILE and then do \"vagrant reload\"."
  exit 0
fi

#if [ -e /dev/disk/by-label/opt ]; then
#    echo "Not creating separate filesystem for /opt (already exists)"
#else
#    # Create a separate filesystem for /opt
#    mkfs -t ext4 -L opt /dev/vda
#    echo -e "LABEL=opt\t/opt\tauto\trelatime\t0\t0" >> /etc/fstab
#fi
#mount -a

apt-get update

# Install Squid and enable caching. Redstack, DevStack and diskimage-builder
# install the same packages again and again, so use hitting the network for
# all of them
apt-get -y install squid3
sed -e 's/^#cache_dir/cache_dir/' -i /etc/squid3/squid.conf
service squid3 restart

if ! grep $http_proxy /etc/environment && ${enable_cache}; then
# Use the proxy server settings in the environment
export http_proxy="http://$host_ip:8080"
export https_proxy="http://$host_ip:8080"
export ftp_proxy="http://$host_ip:8080"
export no_proxy="localhost,127.0.0.1,$this_ip,pypi.python.org,git.fc.usa.hp.com"

  tee -a /etc/environment <<EOF
http_proxy="$http_proxy"
https_proxy="$https_proxy"
ftp_proxy="$ftp_proxy"
no_proxy="$no_proxy"
PIP_DOWNLOAD_CACHE=/tmp/pypi_cache
EOF
fi

# Also use the local proxy server for APT
if ! grep $http_proxy /etc/apt/apt.conf.d/50proxy && ${enable_cache}; then
  tee -a /etc/apt/apt.conf.d/50proxy <<EOF
Acquire::http::Proxy "$http_proxy";
EOF
fi

# Install git (via the local proxy)
apt-get -y install git
apt-get -y install vim
apt-get -y install openssh-server

git config --global user.name "shayne-burgess"
git config --global user.email "shayne.burgess@hp.com"

# ensure the timezone is in UTC - just for ease of comparing timestamps across servers
sudo ln -fs /usr/share/zoneinfo/UTC /etc/localtime

# Hand off to the second part of the provisioning script,
# which must run as a regular user.
sudo useradd  -s /bin/bash -m ubuntu
sudo tee -a /etc/sudoers.d/60-ubuntu <<EOF
ubuntu  ALL=(ALL) NOPASSWD: ALL
EOF
sudo chmod 0440 /etc/sudoers.d/60-ubuntu
sudo ls -l /etc/sudoers.d/60-ubuntu

# Hand off to the second part of the provisioning script,
# which must run as a regular user.
sudo -i -u ubuntu /vagrant/provision-vagrant.sh

# Prevent accidental re-provisioning
touch $PROVFILE

# And we're ready to go.
echo "Done!"
