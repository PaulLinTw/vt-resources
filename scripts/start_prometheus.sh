#!/usr/bin/env bash
set -e

VMID=$1
IP=$2
PORT=$3
echo VMID=$VMID, IP=$IP, PORT=$PORT

#echo clean > /tmp/zk.log

echo update prometheus.yml
cp /home/vagrant/share/prometheus.yml /opt/prometheus/

echo restart prometheus
systemctl restart prometheus.service
