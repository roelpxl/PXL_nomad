sudo echo "192.168.2.5 node" | sudo tee -a /etc/hosts
sudo echo "192.168.2.6 node2" | sudo tee -a /etc/hosts

sudo cat /vagrant/scripts/server/nomad.hcl > /etc/nomad.d/nomad.hcl
sudo cat /vagrant/scripts/server/consul.hcl > /etc/consul.d/consul.hcl

sudo systemctl start consul 
sudo systemctl start nomad 

#sudo consul agent > /dev/null 2>&1 & 
#sudo nomad agent -server -config  /etc/nomad.d/nomad.hcl -> /dev/null 2>&1 & 

sudo nomad job run /vagrant/scripts/webserver.hcl

#sudo system consul start
#sudo system nomad start

#sudo consul agent -config-file /vagrant/scripts/ConsulServerConfig.hcl > /dev/null 2>&1 & 
#sudo nomad agent -config /vagrant/scripts/NomadServerConfig.hcl > /dev/null 2>&1 & 
