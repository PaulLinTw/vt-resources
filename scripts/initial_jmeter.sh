#!/bin/bash
set -e

VMID=$1
IP=$2
PORT=$3
echo VMID=$VMID
echo IP=$IP
echo PORT=$PORT

echo begin initiating jmeter ...

#cd /home/vagrant
#cp share/mllptcpsampler-1.0-SNAPSHOT.jar apache-jmeter-3.1/lib/ext/
echo change jmeter log level to WARN
sed -e "s@log_level.jmeter=INFO@log_level.jmeter=ERROR@g" /home/vagrant/apache-jmeter-3.1/bin/jmeter.properties > /home/vagrant/jmeter.properties1
sed -e "s@log_level.jmeter.junit=DEBUG@log_level.jmeter.junit=ERROR@g" /home/vagrant/jmeter.properties1 > /home/vagrant/jmeter.properties2
sed -e "s@log_level.jorphan=INFO@#log_level.jorphan=ERROR@g" /home/vagrant/jmeter.properties2 > /home/vagrant/apache-jmeter-3.1/bin/jmeter.properties
rm /home/vagrant/jmeter.properties*

echo copy all jar file share to jmeter library folder
{
	cp /home/vagrant/share/*.jar /home/vagrant/apache-jmeter-3.1/lib/ext/
}||{
	echo no jar file copied
}
echo jmeter initiation end.
