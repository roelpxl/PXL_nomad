sudo systemctl start docker
sudo systemctl start consul 
sudo systemctl start nomad 

sudo echo "192.168.1.4 puppet" | sudo tee -a /etc/hosts

consul agent -config-file /vagrant/scripts/ConsulClient2Config.hcl
nomad agent -config /vagrant/scripts/NomadClient2Config.hcl &
