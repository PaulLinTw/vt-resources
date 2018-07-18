#!/bin/bash
set -e

VMID=$1
IP=$2
PORT=$3
echo VMID=$VMID
echo IP=$IP
echo PORT=$PORT

echo copy zoo.cfg
mkdir -p /home/vagrant/local/var/zookeeper
cp /home/vagrant/share/zoo$VMID.cfg /home/vagrant/local/var/zookeeper/zoo$VMID.cfg
echo create myid
echo "$VMID" > /home/vagrant/local/var/zookeeper/myid