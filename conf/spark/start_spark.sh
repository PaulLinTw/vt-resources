source /vagrant/incl.sh
echo "SPARK 啟動開始"

read -p "Type \"yes\" to append JAVA_HOME into spark-env.sh or \"Enter\" to skip." ans1
if [[ $ans1 == "yes" ]]; then
	echo "export JAVA_HOME=$JAVA_HOME" >> share/spark-env.sh
fi

read -p "Type \"yes\" to copy spark-env.sh config files into all nodes or \"Enter\" to skip." ans2
if [[ $ans2 == "yes" ]]; then
	scp share/spark-env.sh vagrant@hdmaster1:/usr/local/spark/conf/
	scp share/spark-env.sh  vagrant@hdslave1:/usr/local/spark/conf/
	scp share/spark-env.sh  vagrant@hdslave2:/usr/local/spark/conf/
	scp share/spark-env.sh  vagrant@hdslave3:/usr/local/spark/conf/
fi

echo starting spark master..
ssh vagrant@hdmaster1 "/usr/local/spark/sbin/start-master.sh"
echo starting worker on hdmaster1..
ssh vagrant@hdmaster1 "/usr/local/spark/sbin/start-slave.sh spark://hdmaster1:7077 && ${JAVA_HOME}/bin/jps"
echo starting worker hdslave1..
ssh vagrant@hdslave1 "/usr/local/spark/sbin/start-slave.sh spark://hdmaster1:7077 && ${JAVA_HOME}/bin/jps"
echo starting worker hdslave2..
ssh vagrant@hdslave2 "/usr/local/spark/sbin/start-slave.sh spark://hdmaster1:7077 && ${JAVA_HOME}/bin/jps"
echo starting worker hdslave3..
ssh vagrant@hdslave3 "/usr/local/spark/sbin/start-slave.sh spark://hdmaster1:7077 && ${JAVA_HOME}/bin/jps"
echo "SPARK 啟動完成"
