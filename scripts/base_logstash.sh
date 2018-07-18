echo begin initiating logstash ...
yum -y update
check=$(yum list -q installed wget)
if [[ $check == "" ]];
then
  echo "installing wget"
  sudo yum install -y -q wget
fi

userhome="/home/vagrant"
cd $userhome
logstash="logstash-2.4.1"

echo downloading $logstash 
#wget -q https://download.elastic.co/logstash/logstash/$logstash.tar.gz
cp share/$logstash.tar.gz .
tar -zxvf $logstash.tar.gz > /dev/null
rm  $logstash.tar.gz
chown vagrant.vagrant -R /$userhome/$logstash/

echo $logstash initiation end.
