source /vagrant/incl.sh

sudo yum install -y wget

sh share/starter_hdfs.sh init
sh share/starter_spark.sh init
sh share/initiate_ge.sh init
