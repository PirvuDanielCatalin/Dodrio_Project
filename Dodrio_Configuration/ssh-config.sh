#!/bin/bash
echo "---------------------------------------------------"
echo "Folderul curent este: $(pwd)"
echo "User curent este: $(whoami)"
echo "---------------------------------------------------"
VAGRANT_HOME=/home/vagrant
ROOT_HOME=/root
if [ ! -d $VAGRANT_HOME/.ssh ]; then
    mkdir $VAGRANT_HOME/.ssh
fi

if [ ! -f $VAGRANT_HOME/.ssh/config ]; then
    cp /shared_folder/config_vagrant $VAGRANT_HOME/.ssh/
    mv $VAGRANT_HOME/.ssh/config_vagrant $VAGRANT_HOME/.ssh/config
fi

if [ ! -f $VAGRANT_HOME/.ssh/id_rsa ]; then
    cp /shared_folder/id_rsa $VAGRANT_HOME/.ssh/
fi

if [ ! -f $VAGRANT_HOME/.ssh/id_rsa.pub ]; then
    cp /shared_folder/id_rsa.pub $VAGRANT_HOME/.ssh/
fi
echo "---------------------------------------------------"
if [ ! -d $ROOT_HOME ]; then
    mkdir $ROOT_HOME
fi

if [ ! -d $ROOT_HOME/.ssh ]; then
    mkdir $ROOT_HOME/.ssh
fi

if [ ! -f $ROOT_HOME/.ssh/config ]; then
    cp /shared_folder/config_root $ROOT_HOME/.ssh/
    mv $ROOT_HOME/.ssh/config_root $ROOT_HOME/.ssh/config
fi

if [ ! -f $ROOT_HOME/.ssh/id_rsa ]; then
    cp /shared_folder/id_rsa $ROOT_HOME/.ssh/
fi

if [ ! -f $ROOT_HOME/.ssh/id_rsa.pub ]; then
    cp /shared_folder/id_rsa.pub $ROOT_HOME/.ssh/
fi
echo "---------------------------------------------------"
public_key=$(cat /shared_folder/id_rsa.pub)
touch $VAGRANT_HOME/.ssh/authorized_keys
touch $ROOT_HOME/.ssh/authorized_keys
grep -q -F "$public_key" $VAGRANT_HOME/.ssh/authorized_keys || echo "$public_key" >> $VAGRANT_HOME/.ssh/authorized_keys
grep -q -F "$public_key" $ROOT_HOME/.ssh/authorized_keys || echo "$public_key" >> $ROOT_HOME/.ssh/authorized_keys
echo "---------------------------------------------------"
chmod 700 $VAGRANT_HOME/.ssh
chmod 644 $VAGRANT_HOME/.ssh/id_rsa.pub
chmod 600 $VAGRANT_HOME/.ssh/id_rsa
chmod 600 $VAGRANT_HOME/.ssh/authorized_keys
chown vagrant:vagrant $VAGRANT_HOME/ -R
echo "---------------------------------------------------"
chmod 700 $ROOT_HOME/.ssh
chmod 644 $ROOT_HOME/.ssh/id_rsa.pub
chmod 600 $ROOT_HOME/.ssh/id_rsa
chmod 600 $ROOT_HOME/.ssh/authorized_keys
chown root:root $ROOT_HOME/ -R
echo "---------------------------------------------------"
find $VAGRANT_HOME/.ssh/ -type f -print0 | xargs -0 dos2unix
find $ROOT_HOME/.ssh/ -type f -print0 | xargs -0 dos2unix
echo "---------------------------------------------------"
if ip a | grep -q 192.168.56.61; then
    hostnamectl set-hostname vm1.proiect.sprint1
fi

if ip a | grep -q 192.168.56.62; then
    hostnamectl set-hostname vm2.proiect.sprint1
fi

if ip a | grep -q 192.168.56.63; then
    hostnamectl set-hostname vm3.proiect.sprint1
fi
echo "---------------------------------------------------"
grep -q -F "192.168.56.61" /etc/hosts || echo "192.168.56.61 vm1.proiect.sprint1" >> /etc/hosts
grep -q -F "192.168.56.62" /etc/hosts || echo "192.168.56.62 vm2.proiect.sprint1" >> /etc/hosts
grep -q -F "192.168.56.63" /etc/hosts || echo "192.168.56.63 vm3.proiect.sprint1" >> /etc/hosts
echo "---------------------------------------------------"
