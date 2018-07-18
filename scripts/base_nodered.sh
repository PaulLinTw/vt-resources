#!/bin/bash
set -e
VMID=$1
IP=$2
PORT=$3
echo VMID=$VMID, IP=$IP, PORT=$PORT
echo begin installing nodered ...
yum -y update
yum install -y wget
yum install -y git

check=$(yum list -q installed nodejs)
if [[ $check == "" ]];
then
  echo "installing nodejs"
  curl --silent --location https://rpm.nodesource.com/setup_7.x | bash -
    yum install -y -q nodejs
fi

npm install -g -q npm-autoinit

npm config set onload-script npm-autoinit/autoinit

npm i -q node-gyp --save-dev

npm i -q bcrypt --save-dev

npm i -q node-red --save-dev

npm uninstall -q node-red-contrib-ui

npm i -q node-red-dashboard --save-dev

npm install -q pm2@latest -g