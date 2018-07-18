#!/bin/bash
set -e

VMID=$1
IP=$2
PORT=$3
echo VMID=$VMID, IP=$IP, PORT=$PORT

echo begin initiating prometheus ...

cd /home/vagrant
yum install -y wget psmisc
wget -O /tmp/prometheus-1.4.1.linux-amd64.tar.gz https://github.com/prometheus/prometheus/releases/download/v1.4.1/prometheus-1.4.1.linux-amd64.tar.gz
useradd prometheus
sudo mkdir /opt/prometheus/
chown prometheus:prometheus /opt/prometheus/
tar -xvf /tmp/prometheus-1.4.1.linux-amd64.tar.gz -C /opt/prometheus --strip=1
cp /home/vagrant/share/prometheus.service /etc/systemd/system/
systemctl start prometheus
systemctl enable prometheus
echo prometheus initiation end.
