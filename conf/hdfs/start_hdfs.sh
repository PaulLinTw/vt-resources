source /vagrant/incl.sh
echo "HDFS 啟動開始"
copyconf(){
	host=$1
	scp share/core-site.xml vagrant@$host:/usr/local/hadoop/etc/hadoop/
	scp share/hdfs-site.xml vagrant@$host:/usr/local/hadoop/etc/hadoop/
	scp share/mapred-site.xml vagrant@$host:/usr/local/hadoop/etc/hadoop/
	scp share/yarn-site.xml vagrant@$host:/usr/local/hadoop/etc/hadoop/
	scp share/workers vagrant@$host:/usr/local/hadoop/etc/hadoop/
}
read -p "Type \"yes\" to copy hadoop config files into all nodes or \"Enter\" to skip." ans
if [[ $ans == "yes" ]]; then
	copyconf hdmaster1
	copyconf hdslave1
	copyconf hdslave2
	copyconf hdslave3
fi

echo starting hdfs ..
cd /usr/local/hadoop/
sbin/start-dfs.sh
sbin/start-yarn.sh
jps
echo "HDFS 啟動完成"
