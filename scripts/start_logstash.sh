#!/usr/bin/env bash
set -e

VMID=$1
IP=$2
PORT=$3
echo VMID=$VMID, IP=$IP, PORT=$PORT

echo copy conf file
cd /home/vagrant/logstash-2.4.1
sed -e "s/<consumerid>/$VMID/g" /home/vagrant/share/logstash.conf > conf/logstash.conf

echo clear log file
echo clear > /tmp/logstash.log

echo Starting logstash
export JAVACMD=`which java`
bin/logstash -f conf/logstash.conf >> /tmp/logstash.log &
