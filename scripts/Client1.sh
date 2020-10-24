sudo systemctl start docker
sudo systemctl start consul 
sudo systemctl start nomad 

sudo echo "192.168.1.4 web" | sudo tee -a /etc/hosts

consul agent -config-file /vagrant/scripts/ConsulClientConfig.hcl
nomad agent -config /vagrant/scripts/NomadClientConfig.hcl &
