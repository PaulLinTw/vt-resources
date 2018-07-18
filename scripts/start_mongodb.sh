#!/bin/bash
set -e
VMID=$1
IP=$2
PORT=$3
echo VMID=$VMID, IP=$IP, PORT=$PORT
echo Starting MongoDB ...

#Step 1: Stop mongo deamon
systemctl stop mongod
# Step 2, Start ConfigServer with Replica Set RS1
mongod --configsvr --replSet rs1 --storageEngine wiredTiger --port 30000 --dbpath ~/mongoDB/data/rs/config --logpath ~/mongoDB/data/rs/config.log --logappend --fork
#Step 3, Start Replica Set RS0
mongod --storageEngine wiredTiger --shardsvr --replSet rs0 --port 20000 --dbpath ~/mongoDB/data/rs --logpath ~/mongoDB/data/rs/rs.log --fork --nojournal
# Step 4, Start Router
mongos --port 40000 --configdb "rs1/$IP:30000" --logpath ~/mongoDB/data/rs/route.log --fork