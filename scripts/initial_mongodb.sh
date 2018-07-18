#!/bin/bash
set -e
VMID=$1
IP=$2
PORT=$3
echo VMID=$VMID, IP=$IP, PORT=$PORT
echo begin initiating MongoDB ...

#Step 1: Stop mongo deamon
systemctl stop mongod

# remove existed DB path
cd ~
rm -rf mongoDB

# Create DBpath
mkdir mongoDB
mkdir mongoDB/data
mkdir mongoDB/data/rs
mkdir mongoDB/data/rs/config

# Step 2, Start ConfigServer with Replica Set RS1
sudo mongod --configsvr --replSet rs1 --storageEngine wiredTiger --port 30000 --dbpath ~/mongoDB/data/rs/config --logpath ~/mongoDB/data/rs/config.log --logappend --fork

#Step 3, Start Replica Set RS0
sudo mongod --storageEngine wiredTiger --shardsvr --replSet rs0 --port 20000 --dbpath ~/mongoDB/data/rs --logpath ~/mongoDB/data/rs/rs.log --fork --nojournal

# Step 4, Start Router
sudo mongos --port 40000 --configdb "rs1/$IP:30000" --logpath ~/mongoDB/data/rs/route.log --fork

# run ONLY ONCE in configsvr server
sudo mongo $IP:30000 --eval "rs.initiate( { _id:'rs1', members:[{ _id:0,host:'$IP:30000'} ]  });"

# run ONLY ONCE in replSet rs0 server
sudo mongo $IP:20000 --eval "rs.initiate( { _id:'rs0', members:[{ _id:0,host:'$IP:20000'} ]  });"

# run ONLY ONCE in mongos server
sudo mongo $IP:40000/admin --eval "db.runCommand({addshard:'rs0/$IP:20000'});"

echo end of MongoDB initial.
