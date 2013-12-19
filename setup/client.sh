#!/bin/bash

ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa

sudo apt-get install -y sshpass

echo "Host 192.168.251.100
    StrictHostKeyChecking no
    User ceph" > ~/.ssh/config

sshpass -p "123qwe" ssh-copy-id ceph@192.168.251.100

wget -q -O- 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc' | sudo apt-key add -
echo deb http://ceph.com/debian-dumpling/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list
sudo apt-get update
sudo apt-get install -y ceph-deploy
