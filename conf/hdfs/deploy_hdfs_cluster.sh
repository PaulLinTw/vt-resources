source /vagrant/incl.sh
echo "HDFS 佈署開始"

echo "壓縮 hadoop 路經，產生 hadoop.tar.gz"
cd /usr/local
rm -fr ./hadoop/tmp
sudo tar -zcf ./hadoop.tar.gz ./hadoop

echo "變更 hadoop.tar.gz 檔案擁有者為 vagrant"
sudo chown -R vagrant:vagrant ./hadoop.tar.gz

echo "hadoop.tar.gz 已可以使用"

echo "複製 hadoop.tar.gz 到各資料節點"
cd /usr/local
scp ./hadoop.tar.gz hdslave1:/home/vagrant
scp ./hadoop.tar.gz hdslave2:/home/vagrant
scp ./hadoop.tar.gz hdslave3:/home/vagrant

echo "解加縮各資料節點的 hadoop.tar.gz"
echo "hdslave1"
ssh hdslave1 "sudo tar -zxf /home/vagrant/hadoop.tar.gz -C /usr/local"
echo "hdslave2"
ssh hdslave2 "sudo tar -zxf /home/vagrant/hadoop.tar.gz -C /usr/local"
echo "hdslave3"
ssh hdslave3 "sudo tar -zxf /home/vagrant/hadoop.tar.gz -C /usr/local"

echo "HDFS 佈署完成"
