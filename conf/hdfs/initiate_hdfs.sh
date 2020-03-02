source /vagrant/incl.sh
set -e
echo "HDFS 初始化開始"

hd_ver="3.2.1"

(read -t 30 -p "請輸入有效的版本號碼，或按 Enter 使用預設版本 $hd_ver（等待 30 秒）：" -r ans )||( echo "" )

if [[ "$ans" != "" ]]; then
	hd_ver=$ans
fi

hdfile="hadoop-$hd_ver.tar.gz"
cd /home/vagrant

if [ -f $hdfile ]; then
   	(read -t 10 -p  "$hdfile 已經存在，是否重新下載（等待 10 秒）？ yes,no（預設）" -r ans )||( echo "" )
else
   ans='yes'
fi
if [[ "$ans" == "yes" ]]; then
	echo "開始下載 $hdfile, 需要幾分鐘時間.."
	wget -q http://www.us.apache.org/dist/hadoop/common/hadoop-$hd_ver/hadoop-$hd_ver.tar.gz
	  
	if [ -f $hdfile ]; then
	   echo "$hdfile 下載完成"
	else
	   echo "$hdfile 下載失敗"
	   exit 1
	fi
fi
echo "將 $hdfile 解壓縮到 /usr/local"
sudo tar -zxf ./hadoop-$hd_ver.tar.gz -C /usr/local

cd /usr/local/

echo "刪除現有的路徑 hadoop"
sudo rm -rf hadoop

echo "將路徑名稱 hadoop-$hd_ver 變更為 hadoop"
sudo mv ./hadoop-$hd_ver ./hadoop

echo "變更路徑擁有者為 vagrant"
sudo chown -R vagrant:vagrant ./hadoop

echo "複製設定檔到 hadoop 路徑中"
cp /home/vagrant/share/core-site.xml /usr/local/hadoop/etc/hadoop/
cp /home/vagrant/share/hdfs-site.xml /usr/local/hadoop/etc/hadoop/
cp /home/vagrant/share/mapred-site.xml /usr/local/hadoop/etc/hadoop/
cp /home/vagrant/share/yarn-site.xml /usr/local/hadoop/etc/hadoop/
cp /home/vagrant/share/workers /usr/local/hadoop/etc/hadoop/

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
echo "export JAVA_HOME=$java_home" >> /usr/local/hadoop/etc/hadoop/hadoop-env.sh

echo "HDFS 初始化完成"
