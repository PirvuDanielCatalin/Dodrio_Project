#!/bin/bash
echo "---------------------------------------------------"
yum install -y vim
yum install -y dos2unix
echo "---------------------------------------------------"
yum install -y firewalld
systemctl start firewalld
systemctl enable firewalld
echo "---------------------------------------------------"
