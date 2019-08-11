#!/bin/bash
sleep 30
mkswap /dev/xvdb
echo $(blkid -s UUID /dev/xvdb | sed -e 's/\"//g' | awk '{printf $2}') none swap sw 0 0 >> /etc/fstab
mount -a
swapon -a
yum install -y git
rpm --import http://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum install -y jenkins
systemctl start jenkins
systemctl enable jenkins
sudo yum install -y java-1.8.0
sudo alternatives --config java
sudo yum -y install maven
sudo yum -y install nodejs
npm install -g @angular/cli


