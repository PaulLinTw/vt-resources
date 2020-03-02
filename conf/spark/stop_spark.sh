source /vagrant/incl.sh
echo "SPARK 結束中"

echo "結束 spark master.."
ssh vagrant@hdmaster1 "/usr/local/spark/sbin/stop-master.sh"
echo "結束 worker on hdmaster1.."
ssh vagrant@hdmaster1 "/usr/local/spark/sbin/stop-slave.sh && $(which jps)"
echo "結束 worker on hdslave1.."
ssh vagrant@hdslave1 "/usr/local/spark/sbin/stop-slave.sh && $(which jps)"
echo "結束 worker on hdslave2.."
ssh vagrant@hdslave2 "/usr/local/spark/sbin/stop-slave.sh && $(which jps)"
echo "結束 worker on hdslave3.."
ssh vagrant@hdslave3 "/usr/local/spark/sbin/stop-slave.sh && $(which jps)"
echo "SPARK 已結束"
