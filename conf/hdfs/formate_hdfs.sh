source /vagrant/incl.sh

echo "格式化命名節點開始"

cd /usr/local/hadoop/
bin/hdfs namenode -format

echo "格式化命名節點完成"
