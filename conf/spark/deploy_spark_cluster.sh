source /vagrant/incl.sh

echo "zipping spark folder .."
cd /usr/local
tar -zcf ./spark.tar.gz ./spark

echo "copy spark.tar.gz into workers"
scp ./spark.tar.gz hdslave1:/home/vagrant
scp ./spark.tar.gz hdslave2:/home/vagrant
scp ./spark.tar.gz hdslave3:/home/vagrant

echo "unzip spark.tar.gz in hdslave1"
ssh hdslave1 "sudo tar -zxf /home/vagrant/spark.tar.gz -C /usr/local"
echo "unzip spark.tar.gz in hdslave2"
ssh hdslave2 "sudo tar -zxf /home/vagrant/spark.tar.gz -C /usr/local"
echo "unzip spark.tar.gz in hdslave3"
ssh hdslave3 "sudo tar -zxf /home/vagrant/spark.tar.gz -C /usr/local"
