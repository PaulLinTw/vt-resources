basevm folder contains following files to create box:

apache-jmeter installation file, it takes very long time to download this large file.
	downloads/apache-jmeter-3.1.tgz

nxlog installation files, you may fail to downlad it on official site sometimes:
	downloads/libdbi-0.8.4-6.el7.x86_64.rpm
	downloads/nxlog-ce-2.9.1716-1_rhel7.x86_64.rpm
	plugins/librdkafka.so.1
	plugins/om_kafka.so

logstash installation file, it takes very long time to download this large file.
	downloads/logstash-2.4.1.tar.gz

jmeter sampler modules:
	samplers/kafkameter-0.2.0.jar, a kafka producer, requires a related jmeter test plan.
	samplers/mllptcpsampler-1.0-SNAPSHOT.jar, a tcp client, requires a related jmeter test plan.
