set -e

VMID=$1
IP=$2
PORT=$3
echo VMID=$VMID
echo IP=$IP
echo PORT=$PORT

echo clear > /tmp/broker.log
#!/bin/bash
kafka_dir=/home/vagrant/local/opt/kafka
cd $kafka_dir

rm -f logs/controller.log.*
rm -f logs/log-cleaner.log.*
rm -f logs/server.log.*
rm -f logs/state-change.log.*

echo update server.properties
cp /home/vagrant/share/server$VMID.properties config/server.properties
echo broker.id=$VMID >> config/server.properties

echo "Stopping Server"
{ # try
        bin/kafka-server-stop.sh config/server.properties
        sleep 5 # Because kafka-server-stop.sh doesn't actually wait
} || { # catch
        echo "Failed to stop  server"
}
echo "Starting server"
if [[  -n $PORT ]]; then
  export JMX_PORT=904$VMID
  export KAFKA_JMX_OPTS="-Djava.rmi.server.hostname=$IP -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false  -Dcom.sun.management.jmxremote.ssl=false "
fi
bin/kafka-server-start.sh config/server.properties 1>> /tmp/broker.log 2>> /tmp/broker.log &
if [[ "$VMID" == "3" ]]; then
        echo "Create --topic kafkatest_BASE"
        sleep 5
        { # try
		JMX_PORT=""
                bin/kafka-topics.sh --create --zookeeper 192.168.1.31:2181 --replication-factor 2 --partitions 6 --topic kafkatest_BASE
        } || { # catch
                echo "No Topic Created"
        }
fi
