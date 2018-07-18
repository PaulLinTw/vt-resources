#!/bin/bash
yum -y update

{
	check=$(yum list -q installed sbt )
	if [[ $check == "" ]];
	then
  		echo installing sbt
  		curl https://bintray.com/sbt/rpm/rpm > bintray-sbt-rpm.repo
		mv bintray-sbt-rpm.repo /etc/yum.repos.d/
  		yum install sbt -y
	fi
}||{}
{
	check=$(yum list -q installed git )
	if [[ $check == "" ]];
	then
		echo installing git
		yum install git -y
	fi
}||{}
{
	echo download and compile kafka manager
	cd ~
	git clone https://github.com/yahoo/kafka-manager.git /home/vagrant/km
	cd /home/vagrant/km
	sbt clean dist
}||{}
