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
  end

end
