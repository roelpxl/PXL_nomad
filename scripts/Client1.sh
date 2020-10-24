sudo systemctl start docker
sudo systemctl start consul 
sudo systemctl start nomad 

consul agent -config-file /vagrant/scripts/ConsulClientConfig.hcl
nomad agent -config /vagrant/scripts/NomadClientConfig.hcl &

sudo echo "192.168.1.4 puppet" | sudo tee -a /etc/hosts
