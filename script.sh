#!/bin/bash
sleep 30
mkswap /dev/xvdb
echo $(blkid -s UUID /dev/xvdb | sed -e 's/\"//g' | awk '{printf $2}') none swap sw 0 0 >> /etc/fstab
mount -a
swapon -a
yum install -y git
yum install vim curl unzip wget -y
yum install java-11-openjdk -y
yum install nexus -y
curl -s https://raw.githubusercontent.com/linuxautomations/nexus/master/install.sh | sudo bash
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-7.9.1.zip
unzip sonarqube-7.9.1.zip
mv sonarqube-7.9.1 sonarqube
