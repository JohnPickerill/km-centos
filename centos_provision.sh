#!/usr/bin/env bash
 
#sudo apt-get -y update
sudo yum -y update

 
if [ ! -f /var/log/vmsetup ];
then
 


# apache
#sudo apt-get -y install apache2
sudo yum install -y httpd
#sudo apt-get -y install libapache2-mod-wsgi python-dev 
sudo yum install -y  mod_wsgi 
sudo yum install -y python-devel
#https
sudo yum install -y  mod_ssl openssl


#sudo mv /etc/apache2/apache2.conf /etc/apache2/apache2.conf.backup
#sudo cp /vagrant/apache2.conf /etc/apache2/apache2.conf
sudo mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.backup
sudo cp /vagrant/httpd.conf /etc/httpd/conf/httpd.conf

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
#TODO this isn't here anymore
sudo cp /vagrant/synonyms.txt /etc/elasticsearch/analysis

#/vagrant/makeindex.bat

#application
cd ~
sudo pip install virtualenv 
#sudo adduser -g apache apps
#sudo passwd apps km1234
sudo mkdir /home/apps
sudo chmod 777 /home/apps
sudo chown vagrant /home/apps
cd /home/apps
sudo su vagrant -c "mkdir demo" 
cd demo
#sudo apt-get -y install git
#sudo yum install -y git

#guide
sudo su vagrant -c 'git clone https://github.com/JohnPickerill/guide.git' 
cd guide/setup
sudo su vagrant -c 'source cfg_python.sh'
sudo su vagrant -c 'source cfg_jinja.sh'
sudo su vagrant -c 'source cfg_elastic.sh'
#guidemgr
cd /home/apps/demo
sudo su vagrant -c 'git clone https://github.com/JohnPickerill/guidemgr.git'
cd guidemgr/setup
sudo su vagrant -c 'source cfg_python.sh'

 

# to act as syslog host
#sudo yum -y install rsyslog
#sudo sed -i.bak 's/\#\$ModLoad im/\$ModLoad im/' /etc/rsyslog.conf
#sudo sed -i.bak 's/\#\$UDPServerRun 514/\$UDPServerRun 514/' /etc/rsyslog.conf
#sudo sed -i.bak 's/\#\$InputTCPServerRun 514/\$InputTCPServerRun 514/' /etc/rsyslog.conf

#sudo service rsyslog restart

#images
#cd /home/apps
#sudo su vagrant -c 'git clone https://github.com/JohnPickerill/km-images.git' 
#sudo su vagrant -c 'ln -s /home/apps/km-images /home/apps/guide/application/static/km-images' 

#firewall
sudo yum install -y iptables
sudo yum install -y iptables-services
#disable firewall d and enable iptables
sudo systemctl mask firewalld
sudo systemctl enable iptables
sudo systemctl enable ip6tables
sudo systemctl stop firewalld
sudo systemctl start iptables
sudo systemctl start ip6tables



# do the rest every time

#firewall
#temporarily accept input make sure we don't get locked out
sudo iptables -P INPUT ACCEPT
#clear
sudo iptables -F
#basic protectiob block null packets, syn flood, xmas tree
sudo iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
sudo iptables -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
sudo iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP
#open up ports
#localhost
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# SSH
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# web
sudo iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT
# ssh change to something other than port 22 and limit incoming
#iptables -A INPUT -p tcp -s YOUR_IP_ADDRESS -m tcp --dport 22 -j ACCEPT

#elasticsearch
sudo iptables -A INPUT -p tcp -m tcp --dport 9200 -j ACCEPT

# syslog
sudo iptables -A INPUT -p tcp -m tcp --dport 514 -j ACCEPT

# block incoming allow outgoing , stop forwarding
sudo iptables FORWARD DROP
sudo iptables -P OUTPUT ACCEPT
sudo iptables -P INPUT DROP

# logging dropped incoming packets to /var/log/messages 
sudo iptables -N LOGGING
sudo iptables -A INPUT -j LOGGING
sudo iptables -A LOGGING -m limit --limit 2/min -j LOG --log-prefix "IPTables-Dropped: " --log-level 4
sudo iptables -A LOGGING -j DROP


# save iptables and 
sudo iptables-save | sudo tee /etc/sysconfig/iptables

touch /var/log/vmsetup

fi

#restart firewall
sudo service iptables restart


#sudo service apache2 restart
sudo service httpd restart
sudo service elasticsearch restart