#!/usr/bin/env bash
set -e
VMID=$1
IP=$2
PORT=$3
echo VMID=$VMID, IP=$IP, PORT=$PORT

echo Begin Redis Installation

# Install EPEL Repo
yum -y install epel-release

# Install Remi Repo
yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm


# Install Redis
yum -y --enablerepo=remi,remi-test install redis

echo End Redis Installation
