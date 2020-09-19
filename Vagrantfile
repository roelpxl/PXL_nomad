# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

#  if Vagrant.has_plugin?("vagrant-cachier")
#    config.cache.scope = :box
#  end

  config.vm.box = "centos/7"
  config.vm.hostname = "nomad"

  config.vm.provider :virtualbox do |virtualbox, override|
    virtualbox.customize ["modifyvm", :id, "--memory", 4096]
  end

  config.vm.provider :lxc do |lxc, override|
    override.vm.box = "visibilityspots/centos-7.x-minimal"
  end
end
