sudo systemctl start docker
sudo systemctl start consul 
sudo systemctl start nomad 

nomad agent -config /vagrant/scripts/NomadServerConfig


