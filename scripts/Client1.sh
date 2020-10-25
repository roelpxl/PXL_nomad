sudo systemctl start docker
sudo systemctl start consul 
sudo systemctl start nomad 

sudo echo "192.168.1.4 server" | sudo tee -a /etc/hosts

consul agent -config-file /vagrant/scripts/ConsulClientConfig.hcl /dev/null 2>&1 & 
nomad agent -config /vagrant/scripts/NomadClientConfig.hcl /dev/null 2>&1 & 
