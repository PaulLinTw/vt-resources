source /vagrant/incl.sh

mode=$1
if [[ $mode == "" ]]; then
	mode="menu"
fi

function sandbox(){
	 $1 || echo "回選單"
}

function auto_mode(){

	echo ""
	echo "起動模式開始執行，任何錯誤將會中斷執行"
	echo ""
	if [[ $mode == "init" ]]; then

		# KEYS INITIATION
		sh ~/share/deploy_keys.sh

		# HDFS INITIATION
		sh ~/share/initiate_hdfs.sh
		sh ~/share/format_hdfs.sh
		sh ~/share/deploy_hdfs_cluster.sh
	fi
	# Run Service
	if [[ $mode == "run" ]]; then
		sh ~/share/start_hdfs.sh
		sh ~/share/start_spark.sh
		sh ~/share/start_ge.sh
	fi

	echo ""
	echo "起動模式執行結束"
}

function menu_mode(){
	tool=$1
	loop=true

	echo ""
	echo "進入選單模式"
	while [[ $loop == true ]]; do

		echo ""
		echo "1|dk  產生並佈署金鑰"
		echo "2|ihd 初始化 HDFS"
		echo "3|dhd 佈署 HDFS 叢集，須先完成『初始化 HDFS』"
		echo "4|fnn 格式化命名節點"
		echo "5|rhd 啟動 HDFS"
		echo "6|ehd 結束 HDFS"
		echo "7|q|x 離開選單"
		echo ""

		if [[ "$tool" == "" ]]; then	
        		read -p "請選擇執行項目：" tool
		fi
		case $tool in
			1|dk)
				sandbox "sh share/deploy_keys.sh"
			    	tool=""
				;;
			2|ihd)
				sandbox "sh share/initiate_hdfs.sh"
			    	tool=""
				;;
			3|dhd)
				sandbox "sh share/deploy_hdfs_cluster.sh"
			    	tool=""
				;;
			4|fnn)
				sandbox "sh share/formate_hdfs.sh"
			    	tool=""
				;;
			5|rhd)
				sandbox "sh share/start_hdfs.sh"
			    	tool=""
				;;
		        6|ehd)
				sandbox "sh share/stop_hdfs.sh"
			    	tool=""
				;;
			7|q|x)
				echo "bye!"
				exit 0
				;;
			*)
			    	echo "無效指令"
			    	tool=""
			    	loop=true
		    ;;
		esac
	done
}

if [[ $mode == "menu" ]]; then
	menu_mode
else
	auto_mode
fi

