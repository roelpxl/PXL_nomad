sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install consul
sudo yum -y install nomad
sudo echo "192.168.1.5 node" | sudo tee -a /etc/hosts
sudo echo "192.168.1.6 node2" | sudo tee -a /etc/hosts
