#!/bin/bash
sleep 30
mkswap /dev/xvdb
echo $(blkid -s UUID /dev/xvdb | sed -e 's/\"//g' | awk '{printf $2}') none swap sw 0 0 >> /etc/fstab
mount -a
swapon -a
