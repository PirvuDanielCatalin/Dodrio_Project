#!/bin/bash
echo "---------------------------------------------------"
yum install -y maven
yum install -y epel-release
yum install -y w3m
echo "---------------------------------------------------"
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=8080/tcp
firewall-cmd --reload
firewall-cmd --list-ports
echo "---------------------------------------------------"
echo " -- VM2 -- "
echo "---------------------------------------------------"
