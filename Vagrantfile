# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(2) do |config|
  config.vm.provision "shell", inline: "echo Hello"
  config.vm.box = "centos/7"
  config.vm.hostname = "nomad"

  config.vm.provider :virtualbox do |virtualbox, override|
    virtualbox.customize ["modifyvm", :id, "--memory", 2048]
  end

  config.vm.define "web" do |web|
    web.vm.hostname = "WEB"
    web.vm.network "private_network", ip: "192.168.1.4", virtualbox__intnet: "mynetwork"
    web.vm.provision "shell", path: "scripts/NomadConsulInstaller.sh"
    web.vm.provision "shell", path: "scripts/Server.sh"
  end

  config.vm.define "node1" do |node1|
   node1.vm.hostname = "NODE1"
   node1.vm.network "private_network", ip: "192.168.1.5", virtualbox__internet: "mynetwork"
   node1.vm.provision "shell", path: "scripts/NomadConsulInstaller.sh"
   node1.vm.provision "shell", path: "scripts/Client1.sh"
   end

  config.vm.define "node2" do |node2|
   node2.vm.hostname = "NODE2"
   node2.vm.network "private_network", ip: "192.168.1.6", virtualbox__internet: "mynetwork"
   node2.vm.provision "shell", path: "scripts/NomadConsulInstaller.sh"
   node2.vm.provision "shell", path: "scripts/Client2.sh"
   end


end
