source /vagrant/incl.sh

echo "Spark 初始化開始"

sp_ver="2.3.1"
hd_ver="3.2.1"

(read -t 30 -p "請輸入有效的 hdfs 版本號碼，或按 Enter 使用預設版本 $hd_ver（等待 30 秒）：" -r ans )||( echo "" && ans="" )

if [[ "$ans" != "" ]]; then
	hd_ver=$ans
fi

(read -t 30 -p "請輸入有效的 spark 版本號碼，或按 Enter 使用預設版本 $sp_ver（等待 30 秒）：" -r ans )||( echo "" && ans="" )

if [[ "$ans" != "" ]]; then
	sp_ver=$ans
fi

spfile="spark-$sp_ver-bin-hadoop$hd_ver.tgz"
cd /home/vagrant

if [ -f $spfile ]; then
   	(read -t 10 -p  "$spfile 已經存在，是否重新下載（等待 10 秒）？ yes,no（預設）" -r ans )||( echo "" && ans="" )
else
   ans='yes'
fi
if [[ "$ans" == "yes" ]]; then
	echo "開始下載 $spfile, 需要幾分鐘時間.."
	wget -q https://archive.apache.org/dist/spark/spark-$sp_ver/spark-$sp_ver-bin-hadoop$hd_ver.tgz
	  
	if [ -f $spfile ]; then
	   echo "$spfile 下載完成"
	else
	   echo "$spfile 下載失敗"
	   exit 1
	fi
fi

echo "將 $spfile 解壓縮到 /usr/local"
tar -zxf ./spark-$sp_ver-bin-hadoop$hd_ver.tgz -C /usr/local

cd /usr/local/

echo "刪除現有的 spark 路徑"
sudo rm -rf spark

echo "將路徑名稱 spark-$sp_ver-bin-hadoop$hd_ver 變更為 spark"
sudo mv ./spark-$sp_ver-bin-hadoop$hd_ver ./spark

echo "變更路徑擁有者為 vagrant"
sudo chown -R vagrant:vagrant ./spark

echo "複製設定檔到 spark 路徑中"
cp /home/vagrant/share/spark-env.sh /usr/local/spark/conf/

if [[ "$JAVA_HOME" == "" ]]; then
	java_home=$(alternatives --display java | grep 'best' | awk '{print $5}' | sed -e 's|/bin/java.||')
	echo "環境變數 JAVA_HOME 未指定，請輸入正確的路徑位置，"
	(read -t 30 -p "或按 Enter 使用建議路徑 $java_home（等待 30 秒）：" -r ans )||( echo "" )
	if [[ "$ans" == "" ]]; then
		java_home=$java_home
	fi
else
	java_home=$JAVA_HOME
	echo "環境變數 JAVA_HOME = $JAVA_HOME"
fi
echo "將 JAVA_HOME 加到 hadoop-env.sh 檔案的尾端"
echo "export JAVA_HOME=$java_home" >> /usr/local/spark/conf/spark-env.sh

echo "Spark 初始化完成"

