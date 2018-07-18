#!/bin/bash
yum -y update

echo begin initiating kafka...

echo create local/opt/ path
mkdir -p /home/vagrant/local/opt
echo downloading kafka
cd /home/vagrant
#kafkaver="0.9.0.1"
kafkaver="0.10.2.0"
yum install -y wget
wget -q http://apache.stu.edu.tw/kafka/$kafkaver/kafka_2.10-$kafkaver.tgz
tar zxf kafka_2.10-$kafkaver.tgz
mv kafka_2.10-$kafkaver /home/vagrant/local/opt/kafka
rm  kafka_2.10-$kafkaver.tgz
chown vagrant.vagrant -R /home/vagrant/local/opt/kafka/

echo kafka initiation end.