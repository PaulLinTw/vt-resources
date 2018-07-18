#!/bin/bash
set -e

VMID=$1
IP=$2
PORT=$3
echo VMID=$VMID
echo IP=$IP
echo PORT=$PORT

echo begin initiating logstash$VMID ...

check=$(yum list -q installed wget)
if [[ $check == "" ]];
then
  echo "installing wget"
  sudo yum install -y -q wget
fi

cd /home/vagrant/logstash-2.4.1
mkdir -p conf
sed -e "s/<consumerid>/$VMID/g" /home/vagrant/share/logstash.conf > conf/logstash.conf
#cp /home/vagrant/share/logstash$VMID.conf  conf/
chown vagrant.vagrant -R /home/vagrant/logstash-2.4.1

echo logstash$VMID initiation end.
