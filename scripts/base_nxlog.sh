echo begin initiating nxlog...

yum -y update
check=$(yum list -q installed wget)
if [[ $check == "" ]];
then
  echo "installing wget"
  sudo yum install -y -q wget
fi

check=$(yum list -q installed apr)
if [[ $check == "" ]];
then
  echo "installing apr"
  sudo yum install -y -q apr
fi

check=$(yum list -q installed libdbi)
if [[ $check == "" ]];
then
  echo "installing libdbi"
  sudo yum install -y -q libdbi
fi


check=$(rpm -qa --last 'nxlog*')
if [[ $check == "" ]];
then
  echo installing nxlog from share/downloads
  # please visit https://nxlog.co/products/nxlog-community-edition/download to get newest version of rpm
  sudo rpm -ivh --quiet /home/vagrant/share/downloads/nxlog-ce-2.9.1716-1_rhel7.x86_64.rpm
fi

echo "copy plugin files"
cp /home/vagrant/share/plugins/om_kafka.so /usr/libexec/nxlog/modules/output/
cp /home/vagrant/share/plugins/librdkafka.so.1 /lib64/
chown nxlog.nxlog /lib64/librdkafka.so.1
echo nxlog setup OK and will start as a service, use systemctl status nxlog to check status