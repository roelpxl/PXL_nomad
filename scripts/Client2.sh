sudo echo "192.168.2.4 server" | sudo tee -a /etc/hosts

sudo cat /vagrant/scripts/client2/nomad.hcl > /etc/nomad.d/nomad.hcl
sudo cat /vagrant/scripts/client2/consul.hcl > /etc/consul.d/consul.hcl

sudo systemctl start consul 
sudo systemctl start nomad 

#sudo consul agent /dev/null 2>&1 & 
#sudo nomad agent -client -config  /etc/nomad.d/nomad.hcl -> /dev/null 2>&1 & 
