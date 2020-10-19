sudo systemctl start docker
sudo systemctl start consul 
sudo systemctl start nomad 

consul agent -config-file /vagrant/scripts/ConsulClient1Config.hcl
nomad agent -config /vagrant/scripts/NomadClient1Config.hcl

