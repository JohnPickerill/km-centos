#!/usr/bin/env bash

 
#sudo apt-get -y update
#sudo yum -y update


if [ ! -f /var/log/vmsetup ];
then
# apache
#sudo apt-get -y install apache2
sudo yum install -y httpd
#sudo apt-get -y install libapache2-mod-wsgi python-dev 
sudo yum install -y  mod-wsgi 
sudo yum install -y python-devel
#sudo mv /etc/apache2/apache2.conf /etc/apache2/apache2.conf.backup
#sudo cp /vagrant/apache2.conf /etc/apache2/apache2.conf
#sudo mv /etc/httpd/httpd.conf /etc/httpd/httpd.conf.backup
#sudo cp /vagrant/httpd.conf /etc/httpd/httpd.conf

#python - flask
#sudo apt-get -y install python-openssl
 
#sudo apt-get -y install libffi-dev 
sudo yum install -y libffi-devel
#sudo apt-get -y install libssl-dev
sudo yum install -y libffi-devel

#sudo apt-get -y install python
#sudo apt-get -y install python-pip 

#elasticsearch
cd ~
#sudo apt-get -y curl
#sudo apt-get install -y  openjdk-6-jre
#wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.7.deb
#dpkg -i elasticsearch-0.90.7.deb
/vagrant/makeindex.bat

#application
sudo pip install virtualenv 
sudo mkdir /home/apps
sudo chmod 777 /home/apps
sudo chown vagrant /home/apps
cd /home/apps
#sudo apt-get -y install git
#sudo yum install -y git
sudo su vagrant -c 'git clone https://github.com/JohnPickerill/km-prototype-a.git' 
cd km-prototype-a
sudo su vagrant -c 'virtualenv venv' 
sudo su vagrant -c 'venv/bin/pip install -r /vagrant/requirements.pip'

 

#    touch /var/log/vmsetup
fi

#sudo service apache2 restart