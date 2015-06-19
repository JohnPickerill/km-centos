#!/usr/bin/env bash

 
#sudo apt-get -y update
#sudo yum -y update


if [ ! -f /var/log/vmsetup ];
then
# apache
#sudo apt-get -y install apache2
sudo yum install -y httpd
#sudo apt-get -y install libapache2-mod-wsgi python-dev 
sudo yum install -y  mod_wsgi 
sudo yum install -y python-devel
#sudo mv /etc/apache2/apache2.conf /etc/apache2/apache2.conf.backup
#sudo cp /vagrant/apache2.conf /etc/apache2/apache2.conf
sudo mv /etc/httpd/httpd.conf /etc/httpd/httpd.conf.backup
sudo cp /vagrant/httpd.conf /etc/httpd/httpd.conf

#python - flask
#sudo apt-get -y install python-openssl
 
#sudo apt-get -y install libffi-dev 
sudo yum install -y libffi-devel
#sudo apt-get -y install libssl-dev
 

#sudo apt-get -y install python
#sudo apt-get -y install python-pip 

#elasticsearch (already installed on lr box)
cd ~
#sudo apt-get -y curl
#sudo apt-get install -y  openjdk-6-jre
#wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.7.deb
#dpkg -i elasticsearch-0.90.7.deb

# install marvel and sense
cd /usr/share/elasticsearch
sudo bin/plugin -i elasticsearch/marval/latest
cd /etc/elasticsearch
sudo cp /etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml.old
sudo cp /vagrant/elasticsearch.yml /etc/elasticsearch
sudo service elasticsearch restart

# elasticsearch synonyms
sudo mkdir /etc/elasticsearch/analysis
sudo cp /vagrant/synonyms.txt /etc/elasticsearch/analysis

#/vagrant/makeindex.bat

#application
cd ~
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
sudo su vagrant -c 'cp config.py devconfig.py'

#images
cd /home/apps
sudo su vagrant -c 'git clone https://github.com/JohnPickerill/km-images.git' 
sudo su vagrant -c 'ln -s /home/apps/km-images /home/apps/km-prototype-a/application/static/km-images' 

#    touch /var/log/vmsetup


#sudo service apache2 restart
sudo service httpd restart