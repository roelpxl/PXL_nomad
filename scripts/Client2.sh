sudo systemctl start docker
sudo systemctl start consul 
sudo systemctl start nomad 

sudo echo "192.168.1.4 server" | sudo tee -a /etc/hosts
sudo echo "DEVICE=eth0" > /etc/sysconfig/network-scripts/ifcfg-eth0 && sudo service network restart

consul agent -config-file /vagrant/scripts/ConsulClient2Config.hcl /dev/null 2>&1 & 
nomad agent -config /vagrant/scripts/NomadClient2Config.hcl /dev/null 2>&1 & 
