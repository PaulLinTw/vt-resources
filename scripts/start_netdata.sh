#!/usr/bin/env bash
set -e

VMID=$1
IP=$2
PORT=$3
echo VMID=$VMID
echo IP=$IP
echo PORT=$PORT

#echo clean > /tmp/zk.log

#echo pudate netdata.cfg
#cp /home/vagrant/share/netdata.cfg 

echo restart netdata
{
killall netdata
}||{
echo netdata is not running
}
/usr/sbin/netdata
