#!/usr/bin/env bash
set -e

VMID=$1
IP=$2
PORT=$3
echo VMID=$VMID
echo IP=$IP
echo PORT=$PORT

echo clean > /tmp/zk.log

echo copy zoo.cfg
cp /home/vagrant/share/zoo$VMID.cfg /home/vagrant/local/var/zookeeper/zoo$VMID.cfg

echo "Killing ZooKeeper"
/home/vagrant/local/opt/zookeeper-3.4.9/bin/zkServer.sh stop  /home/vagrant/local/var/zookeeper/zoo$VMID.cfg
sleep 5 # Because zookeeper-server-stop.sh doesn't actually wait
echo "Starting ZooKeeper"
if [[  -n $PORT ]]; then
  export JMX_PORT=903$VMID
  export KAFKA_JMX_OPTS="-Djava.rmi.server.hostname=$IP -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false  -Dcom.sun.management.jmxremote.ssl=false "
fi
/home/vagrant/local/opt/zookeeper-3.4.9/bin/zkServer.sh start /home/vagrant/local/var/zookeeper/zoo$VMID.cfg 1>> /tmp/zk.log 2>> /tmp/zk.log &