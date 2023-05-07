#!/bin/bash
echo "---------------------------------------------------"
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --reload
firewall-cmd --list-ports
echo "---------------------------------------------------"
echo " -- VM1 -- "
echo "---------------------------------------------------"
