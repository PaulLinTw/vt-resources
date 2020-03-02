source /vagrant/incl.sh

sh share/starter_hdfs.sh run
sh share/starter_spark.sh run
sh share/start_graphite_exporter.sh
