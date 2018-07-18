#!/bin/bash
set -e

VMID=$1
IP=$2
PORT=$3
echo VMID=$VMID
echo IP=$IP
echo PORT=$PORT

echo begin initiating netdata ...

cd /home/vagrant
yum install -y -q zlib-devel gcc make git autoconf autogen automake pkgconfig psmisc libuuid-devel
rm -rf netdata
git clone https://github.com/firehol/netdata.git --depth=1
cd netdata
./netdata-installer.sh
echo netdata initiation end.
