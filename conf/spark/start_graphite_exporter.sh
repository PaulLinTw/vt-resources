source /vagrant/incl.sh
echo "graphic exporter 啟動開始"
cd go/src/github.com/prometheus/graphite_exporter
./graphite_exporter --graphite.mapping-config="/home/vagrant/share/ge_mapping" &
echo "graphic exporter 啟動完成"
