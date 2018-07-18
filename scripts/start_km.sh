set -e

VMID=$1
IP=$2
PORT=$3
echo VMID=$VMID
echo IP=$IP
echo PORT=$PORT

cd /home/vagrant/
echo copy conf file
cp share/application.conf kafka-manager-*/conf/
cd kafka-manager-*
echo Starting Kafka Manager 
bin/kafka-manager -Dconfig.file=conf/application.conf -Dhttp.port=8080 -java-home /usr/lib/jvm/jdk1.8.0_102/ >>/tmp/kafka-manager.log &