#!/bin/bash
set -e

VMID=$1
IP=$2
PORT=$3
echo VMID=$VMID
echo IP=$IP
echo PORT=$PORT

echo begin initiating nxlog...

echo "copy config file"
cp /home/vagrant/share/nxlog.conf /etc/
echo "copy plugin files"
cp /home/vagrant/share/om_kafka.so /usr/libexec/nxlog/modules/output/
cp /home/vagrant/share/librdkafka.so.1 /lib64/
chown vagrant.vagrant /lib64/librdkafka.so.1
chown vagrant.vagrant /usr/libexec/nxlog/modules/output/om_kafka.so

check=$(rpm -qa --last 'nxlog*')
if [[ $check == "" ]]; then
  echo installing nxlog from share/downloads
  # please visit https://nxlog.co/products/nxlog-community-edition/download to get newest version of rpm
	cp /home/vagrant/share/downloads/nxlog-ce-2.9.1716-1_rhel7.x86_64.rpm
	rpm -ivh --quiet /home/vagrant/share/downloads/nxlog-ce-2.9.1716-1_rhel7.x86_64.rpm
else
	systemctl restart nxlog
fi

echo nxlog setup OK and will start as a service, use systemctl status nxlog to check status