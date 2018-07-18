#!/bin/bash
set -e
VMID=$1
IP=$2
PORT=$3
echo VMID=$VMID, IP=$IP, PORT=$PORT
echo begin initiating nodered ...

pm2 startup

pm2 start /home/vagrant/node_modules/node-red/red.js -- --settings /home/vagrant/node_modules/node-red/settings.js

pm2 save

echo end of nodered initial.