#!/bin/bash
set -e

VMID=$1
IP=$2
PORT=$3
echo VMID=$VMID
echo IP=$IP
echo PORT=$PORT

echo clear nxlog.log
echo clear > /var/log/nxlog/nxlog.log

echo copy config file
cp /home/vagrant/share/nxlog.conf /etc/
echo restart nxlog

systemctl restart nxlog