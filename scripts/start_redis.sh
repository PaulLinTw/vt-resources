#!/bin/bash
set -e
VMID=$1
IP=$2
PORT=$3
echo VMID=$VMID, IP=$IP, PORT=$PORT

echo begin redis start

# Start Redis service
systemctl restart redis.service
# Ping Redis
redis-cli ping

echo end redis start
