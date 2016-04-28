# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

   config.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.cpus = 1
   end     

   config.vm.box = "landregistry/centos-beta"
#  config.vm.box = "hashicorp/precise64"
   config.vm.network "public_network", :bridge => '300Mbps Wireless USB Adapter'

#  config.vm.network "public_network", ip: "192.168.1.201"
# default router
#  config.vm.provision "shell",
#		run: "always",
#		inline: "route add default gw 192.168.1.1"  	
# delete default gw on eth0
#	config.vm.provision "shell",
#		run: "always",
#		inline: "eval `route -n | awk '{ if ($8 ==\"enp0s3\" && $2 != \"0.0.0.0\") print \"route del default gw \" $2; }'`" 


  config.vm.network "forwarded_port", guest: 5001, host: 5004
  config.vm.network :forwarded_port, guest: 80, host: 10080
  config.vm.network :forwarded_port, guest: 9200, host: 9200 

  config.vm.hostname ="guide"
  config.vm.provision "shell", path: "centos_provision.sh"
end
 

 
 