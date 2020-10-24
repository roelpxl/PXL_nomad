sudo systemctl start docker
sudo systemctl start consul 
sudo systemctl start nomad 

sudo echo "192.168.1.5 node" | sudo tee -a /etc/hosts
sudo echo "192.168.1.6 node2" | sudo tee -a /etc/hosts

consul agent -config-file /vagrant/scripts/ConsulServerConfig.hcl
nomad agent -config /vagrant/scripts/NomadServerConfig.hcl &


