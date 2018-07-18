#!/bin/bash
set -e

VMID=$1
IP=$2
PORT=$3
echo VMID=$VMID
echo IP=$IP
echo PORT=$PORT

cd /home/vagrant/
rm -f -r kafka-manager-*

cp /home/vagrant/km/target/universal/*.zip .
unzip *.zip
rm -f *.zip
echo Deploy kafka-manager ...
chown -R vagrant.vagrant kafka-manager-*
echo copy conf file 
cp share/application.conf kafka-manager-*/conf/
echo kafka-manager is deployed