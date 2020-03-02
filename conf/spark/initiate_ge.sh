source /vagrant/incl.sh

echo "Graphite Exporter 初始化開始"

sp_ver="2.3.0"

echo "install git"
sudo  yum -y install git
echo "install golang"
cd ~
git clone https://github.com/canha/golang-tools-install-script.git
cd golang-tools-install-script/
(bash goinstall.sh && source /home/vagrant/.bashrc)||( echo "" )
echo "download graphite_exporter to go/src/github.com/prometheus/"
mkdir -p go/src/github.com/prometheus/
cd go/src/github.com/prometheus/
git clone https://github.com/prometheus/graphite_exporter.git
echo "build graphite_exporter"
cd graphite_exporter/
make
echo "graphite_exporter 產生於 /home/vagrant/golang-tools-install-script/go/src/github.com/prometheus/graphite_exporter 路徑中。"
echo "Graphite Exporter 初始化完成"
