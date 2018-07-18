#!/bin/bash
set -e

VMID=$1
IP=$2
PORT=$3

PLAN=kafka

KAFKA_LOOPS="5000000"	# -1 means forever
KAFKA_SCHEDULER="false"
KAFKA_SCHEDULER_DELAY=10
KAFKA_DURATION=60
KAFKA_DURATION_END=$(expr $KAFKA_DURATION + $KAFKA_SCHEDULER_DELAY)
dopt1=
ds=`date --date "$KAFKA_SCHEDULER_DELAY seconds" +"%Y-%m-%d %H:%M:%S"`
de=`date --date "$KAFKA_DURATION_END seconds" +"%Y-%m-%d %H:%M:%S"`
KAFKA_START_TIME=$(date -d "$ds" +"%s")
KAFKA_END_TIME=$(date -d "$de" +"%s")

if [ "$KAFKA_SCHEDULER" == "true" ]; then
	echo	"Test will begin at $ds"
	echo	"        and end at $de"
fi
KAFKA_MESSAGE=$(cat share/log.3k)

TCP_THREADS=800
TCP_RAMPTIME=1
KAFKA_THREADS=1
KAFKA_RAMPTIME=1
KAFKA_INTERVAL=1

echo VMID=$VMID
echo IP=$IP
echo PORT=$PORT

cd /home/vagrant/apache-jmeter-3.1
echo Stop current test ...
bin/shutdown.sh
sleep 5 # Because shutdown.sh doesn't actually wait

echo clear jmeter log
{
rm /home/vagrant/apache-jmeter-3.1/jmeter.log
rm /home/vagrant/*.jmx
}||
{
	echo nothing cleared
}

echo Copy Test Plan $PLAN.jmx...
cp /home/vagrant/share/$PLAN.jmx /home/vagrant/$PLAN.jmx
sed -e "s!KafakLoops!$KAFKA_LOOPS!g" /home/vagrant/$PLAN.jmx> /home/vagrant/$PLAN.tmp1
sed -e "s!KafakScheduler!$KAFKA_SCHEDULER!g" /home/vagrant/$PLAN.tmp1> /home/vagrant/$PLAN.tmp2
sed -e "s!KafakDuration!$KAFKA_DURATION!g" /home/vagrant/$PLAN.tmp2> /home/vagrant/$PLAN.tmp1
sed -e "s!KafkaStartTime!$KAFKA_START_TIME!g" /home/vagrant/$PLAN.tmp1> /home/vagrant/$PLAN.tmp2
sed -e "s!KafkaEndTime!$KAFKA_END_TIME!g" /home/vagrant/$PLAN.tmp2> /home/vagrant/$PLAN.tmp1
sed -e "s!NumOfTCPThreads!$TCP_THREADS!g" /home/vagrant/$PLAN.tmp1 > /home/vagrant/$PLAN.tmp2
sed -e "s!TCPRampTime!$TCP_RAMPTIME!g" /home/vagrant/$PLAN.tmp2> /home/vagrant/$PLAN.tmp1
sed -e "s!NumOfKafkaThreads!$KAFKA_THREADS!g" /home/vagrant/$PLAN.tmp1> /home/vagrant/$PLAN.tmp2
sed -e "s!KafkaRampTime!$KAFKA_RAMPTIME!g" /home/vagrant/$PLAN.tmp2> /home/vagrant/$PLAN.tmp1
sed -e "s!KafkaInterval!$KAFKA_INTERVAL!g" /home/vagrant/$PLAN.tmp1> /home/vagrant/$PLAN.tmp2
sed -e "s!KafkaMessage!$KAFKA_MESSAGE!g" /home/vagrant/$PLAN.tmp2> /home/vagrant/$PLAN.tmp1
sed -e "s!NXLOGIP!192.168.1.21$VMID!g" /home/vagrant/$PLAN.tmp1> /home/vagrant/$PLAN.jmx
#rm /home/vagrant/*.tmp*

echo Start jmeter with $PLAN.jmx ...
JVM_ARGS="-Xms512m -Xmx1536m" bin/jmeter -n -t /home/vagrant/$PLAN.jmx >> /home/vagrant/test.log &
