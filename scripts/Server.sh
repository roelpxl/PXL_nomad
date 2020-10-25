sudo systemctl start docker
sudo systemctl start consul 
sudo systemctl start nomad 

sudo echo "192.168.2.5 node" | sudo tee -a /etc/hosts
sudo echo "192.168.2.6 node2" | sudo tee -a /etc/hosts

sudo consul agent -config-file /vagrant/scripts/ConsulServerConfig.hcl > /dev/null 2>&1 & 
sudo nomad agent -config /vagrant/scripts/NomadServerConfig.hcl > /dev/null 2>&1 & 


