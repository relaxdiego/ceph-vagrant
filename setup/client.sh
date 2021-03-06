#!/bin/bash

su vagrant -c "ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa"

sudo apt-get install -y sshpass

echo -e "192.168.251.100\tnode1" >> /etc/hosts

echo "Host node1
    HostName 192.168.251.100
    StrictHostKeyChecking no
    User ceph" > /home/vagrant/.ssh/config

su vagrant -c "sshpass -p '123qwe' ssh-copy-id ceph@node1"

wget -q -O- 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc' | sudo apt-key add -
echo deb http://ceph.com/debian-emperor/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list
sudo apt-get update
sudo apt-get install ceph-common -y
sudo apt-get install -y ceph-deploy

su vagrant -c "ceph-deploy install node1"
su vagrant -c "ceph-deploy new node1"
su vagrant -c "ceph-deploy mon create node1"
su vagrant -c "ceph-deploy gatherkeys node1"
su vagrant -c "ceph-deploy disk zap node1:sdb"
su vagrant -c "ceph-deploy disk prepare node1:sdb"
su vagrant -c "ceph-deploy mds create node1"
