sudo echo "192.168.2.4 server" | sudo tee -a /etc/hosts

sudo systemctl start docker

sudo cat /vagrant/scripts/server/nomad.hcl > /etc/nomad.d/nomad.hcl
sudo cat /vagrant/scripts/server/consul.hcl > /etc/consul.d/consul.hcl

sudo systemctl start consul 
sudo systemctl start nomad 

sudo consul agent /dev/null 2>&1 & 
sudo nomad agent /dev/null 2>&1 & 
