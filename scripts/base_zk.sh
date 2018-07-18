#!/bin/bash
echo zookeeper initiation begin ...

yum -y update

yum install -y -q wget
echo downloading zookeeper
wget -q http://apache.stu.edu.tw/zookeeper/zookeeper-3.4.9/zookeeper-3.4.9.tar.gz
tar zxf zookeeper-3.4.9.tar.gz
echo create local/opt path
mkdir -p /home/vagrant/local/opt
mkdir -p /home/vagrant/local/var/zookeeper
cp -R  zookeeper-3.4.9/ /home/vagrant/local/opt
rm  zookeeper-3.4.9.tar.gz
chown vagrant.vagrant -R /home/vagrant/local/

echo zookeeper initiation end.