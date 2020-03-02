source /vagrant/incl.sh

mkdir -p /home/vagrant/.ssh

echo "金鑰產生並佈署開始"

ssh-keygen -P "" -t rsa -f /home/vagrant/.ssh/id_rsa

ssh-copy-id -i /home/vagrant/.ssh/id_rsa.pub hdmaster1
ssh-copy-id -i /home/vagrant/.ssh/id_rsa.pub hdslave1
ssh-copy-id -i /home/vagrant/.ssh/id_rsa.pub hdslave2
ssh-copy-id -i /home/vagrant/.ssh/id_rsa.pub hdslave3

echo "金鑰產生並佈署完成"
