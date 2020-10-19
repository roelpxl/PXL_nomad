# Nomad consul

The aim of this project is to provide a development environment based on [consul](https://www.consul.io) and [nomad](https://www.nomadproject.io) to manage container based microservices.

The following steps should make that clear;

bring up the environment by using [vagrant](https://www.vagrantup.com) which will create centos 7 virtualbox machine or lxc container.

The proved working vagrant providers used on an [ArchLinux](https://www.archlinux.org/) system are
* [vagrant-lxc](https://github.com/fgrehm/vagrant-lxc)
* [vagrant-libvirt](https://github.com/vagrant-libvirt/)
* [virtualbox](https://www.virtualbox.org/)

```bash
    $ vagrant up --provider lxc
    OR
    $ vagrant up --provider libvirt
    OR
    $ vagrant up --provider virtualbox
```

Once it is finished, you should be able to connect to the vagrant environment through SSH and interact with Nomad:

```bash
    $ vagrant ssh
    [vagrant@nomad ~]$
```
Plan van aanpak: Eerst een nomad cluster opstellen. Vervolgens deze cluster laten voldoen aan de voorwaarden in de opdracht. En als laatste stop de VagrantFile configureren zodat dit allemaal (de cluster) gebeurt via vagrant up --provision


first step (moet op de 3 vms):
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install consul
sudo yum -y install nomad
sudo yum -y install git

sudo su -
service consul start
service nomad start
exit



