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

		# SPARK INITIATION
		sh ~/share/initiate_scalar.sh
		sh ~/share/initiate_spark.sh
		sh ~/share/spark-env.sh
		sh ~/share/deploy_spark_cluster.sh

		# GE INITIATION
		sh ~/share/initiate_ge.sh
	fi
	# Run Service
	if [[ $mode == "run" ]]; then
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
		echo "1|isc 初始化 Scalar"
		echo "2|isp 初始化 Spark"
		echo "3|ige 初始化 Graphic Exporter"
		echo "4|dsp 佈署 SPARK 叢集"
		echo "5|rse 執行 spark-env.sh"
		echo "6|rsp 啟動 Spark"
		echo "7|rge 啟動 graphic exporter"
		echo "8|esp 結束 Spark"
		echo "9|q|x 離開選單"
		echo ""

		if [[ "$tool" == "" ]]; then	
        		read -p "請選擇執行項目：" tool
		fi
		case $tool in
			3|isc)
				sandbox "sh share/initiate_scalar.sh"
			    	tool=""
				;;
			4|isp)
				sandbox "sh share/initiate_spark.sh"
			    	tool=""
				;;
			5|ige)
				sandbox "sh share/initiate_ge.sh"
			    	tool=""
				;;
			9|dsp)
				sandbox "sh share/deploy_spark_cluster.sh"
			    	tool=""
				;;
		        10|rse)
				sandbox "sh share/spark-env.sh"
			    	tool=""
				;;
		        11|rsp)
				sandbox "sh share/start_spark.sh"
			    	tool=""
				;;
		        12|rge)
				sandbox "sh share/start_graphite_exporter.sh"
			    	tool=""
				;;
		        14|esp)
				sandbox "sh share/stop_spark.sh"
			    	tool=""
				;;
			15|q|x)
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

