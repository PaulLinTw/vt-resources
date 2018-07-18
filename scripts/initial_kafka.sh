set -e

VMID=$1
IP=$2
PORT=$3
echo VMID=$VMID
echo IP=$IP
echo PORT=$PORT

echo update server.properties
cp /home/vagrant/share/server$VMID.properties /home/vagrant/local/opt/kafka/config/server.properties
echo broker.id=$VMID >> /home/vagrant/local/opt/kafka/config/server.properties
#chown vagrant.vagrant -R /home/vagrant/local/opt/kafka/