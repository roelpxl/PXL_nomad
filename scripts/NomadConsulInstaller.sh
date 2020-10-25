sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install consul
sudo yum -y install nomad

echo "-------Try to install docker---------"

sudo yum install -y yum-utils
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
    
#sudo yum -y install docker-ce docker-ce-cli containerd.io
sudo yum -y install docker
