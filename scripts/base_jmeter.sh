#!/bin/bash
set -e

VMID=$1
IP=$2
PORT=$3
echo VMID=$VMID
echo IP=$IP
echo PORT=$PORT

echo begin initiating jmeter ...

yum -y update
yum install -y wget
yum install -y git

cd /home/vagrant
cp share/apache-jmeter-3.1.tgz .
tar -zxvf apache-jmeter-3.1.tgz >/dev/null
cp share/mllptcpsampler-1.0-SNAPSHOT.jar apache-jmeter-3.1/lib/ext/

#wget http://mirror.olnevhost.net/pub/apache/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.tar.gz
#tar xvf apache-maven-3.0.5-bin.tar.gz >/dev/null
#mv /home/vagrant/apache-maven-3.0.5 /home/vagrant/apache-maven

#echo export M2_HOME=/home/vagrant/apache-maven >> /home/vagrant/.bashrc
#echo export M2=\$M2_HOME/bin >> /home/vagrant/.bashrc
#echo export PATH=\$M2:$PATH >> /home/vagrant/.bashrc
#source /home/vagrant/.bashrc
#mvn -version

#git clone --quiet https://github.com/BrightTag/kafkameter.git
#cd kafkameter
#mvn package
#cp target/kafkameter-* /home/vagrant/apache-jmeter-3.1/lib/ext/
cp share/kafkameter-0.2.0.jar apache-jmeter-3.1/lib/ext/

rm apache-jmeter-3.1.tgz

echo jmeter initiation end.
