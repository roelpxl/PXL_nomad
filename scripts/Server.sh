sudo systemctl start docker
sudo systemctl start consul 
sudo systemctl start nomad 

sudo echo "192.168.1.5 node" | sudo tee -a /etc/hosts
sudo echo "192.168.1.6 node2" | sudo tee -a /etc/hosts
echo "DEVICE=eth0" > /etc/sysconfig/network-scripts/ifcfg-eth0 && service network restart

consul agent -config-file /vagrant/scripts/ConsulServerConfig.hcl > /dev/null 2>&1 & 
nomad agent -config /vagrant/scripts/NomadServerConfig.hcl > /dev/null 2>&1 & 


