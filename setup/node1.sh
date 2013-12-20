#!/bin/bash

sudo apt-get install -y openssh-server

# ceph-deploy installs packages onto nodes. This
# means that the user you create requires passwordless
# sudo privileges.
sudo useradd -d /home/ceph -m ceph
echo 'ceph:123qwe' | sudo chpasswd

echo "ceph ALL = (root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ceph
sudo chmod 0440 /etc/sudoers.d/ceph
