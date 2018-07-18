#!/bin/bash
set -e
VMID=$1
IP=$2
PORT=$3
echo VMID=$VMID, IP=$IP, PORT=$PORT
echo begin installing MongoDB ...
yum -y update
yum install -y wget
yum install -y git

# remove old mongodb then install new one
yum remove -y mongodb-org-* mongodb-org-server-*

echo "[mongodb-enterprise]
name=MongoDB Enterprise Repository
baseurl=https://repo.mongodb.com/yum/redhat/\$releasever/mongodb-enterprise/3.4/\$basearch/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc" > /etc/yum.repos.d/mongodb.repo

# Install MongoDB
yum install -y mongodb-enterprise

echo end of MongoDB installed.
