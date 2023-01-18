# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.ssh.insert_key = false
  config.vm.box_check_update = false 
  config.vm.define "testpostgresql"
  config.vm.hostname = "testpostgresql"
  config.vm.box_download_insecure=true
  config.vm.network :forwarded_port, guest: 5432, host: 5433
  config.vm.network "private_network", ip: "192.168.10.100"
  config.vm.synced_folder "test_project", "/home/vagrant/test_project"
  config.vm.provision "shell", path: "provision.sh"

  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--uart1", "0x3F8", "4"]
    v.customize ["modifyvm", :id, "--uartmode1", "file", File::NULL]
  end  
end