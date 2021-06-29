#!/bin/bash

sleep 30

sudo adduser kroton 

echo -e "keOnyLN##kroton\nkeOnyLN##kroton" | passwd kroton

echo "kroton ALL=(ALL)  NOPASSWD:ALL" >> /etc/sudoers

sudo sed -i '/PasswordAuthentication yes/s/^#//' /etc/ssh/sshd_config

sudo sed -i "s/PasswordAuthentication no/#PasswordAuthentication no/g" /etc/ssh/sshd_config

sudo service sshd restart

if egrep -i '(debian|ubuntu)' /etc/*-release >/dev/null
then
    echo "Baseado em Debian - APT" > /tmp/userdata_status
    sudo apt-get -y update && sudo apt-get -y install git python3 python3-pip vim nginx
    sudo rm /usr/bin/python && sudo /bin/ln -s python3 /usr/bin/python

elif egrep -i '(centos|redhat)' /etc/*-release >/dev/null
then
    echo "Baseado em RedHat - YUM" > /tmp/userdata_status
    sudo yum -y install git python3 python3-pip vim nginx
    sudo rm /usr/bin/python && sudo /bin/ln -s python3 /usr/bin/python 
    

else
    echo "Distribuição não eh suportada" > /tmp/userdata_status
fi


echo "Success!" >> /tmp/userdata_status
