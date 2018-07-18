#!/bin/bash
set -e
VMID=$1
IP=$2
PORT=$3
echo VMID=$VMID, IP=$IP, PORT=$PORT
echo begin initiating Redis ...

# modify redis conf

REDIS_MASTER_PASS=btdsclab

cd /home/vagrant/share
if [[ "$VMID" == "1" ]]; then
        echo "Modify Redis Master Conf"
        sed -e "s!#requirepass foobared!requirepass $REDIS_MASTER_PASS!g" redis.conf> redis_.conf
else
        echo "Modify Redis Slave Conf"
        sed -e "s!#requirepass foobared!requirepass $REDIS_MASTER_PASS!g" redis.conf > redis_1.conf
        sed -e "s!# slaveof <masterip> <masterport>!slaveof redis1 6379!g" redis_1.conf > redis_2.conf
        sed -e "s!# masterauth <master-password>!masterauth $REDIS_MASTER_PASS!g" redis_2.conf > redis_.conf
fi
cp redis_.conf /etc/redis.conf

# Enable the Redis service to start on server boot
sudo systemctl daemon-reload
sudo systemctl enable redis.service

echo end of Redis initial.
