sudo systemctl start docker
sudo systemctl start consul 
sudo systemctl start nomad 

consul agent -config-file /vagrant/scripts/ConsulServerConfig
nomad agent -config /vagrant/scripts/NomadServerConfig


