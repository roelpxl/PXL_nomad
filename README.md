# Nomad consul

The aim of this project is to provide a development environment based on consul and nomad to manage container based microservices.

The following steps should make that clear;

bring up the environment by using vagrant which will create centos 7 virtualbox machine or lxc container.

The proved working vagrant providers used on an ArchLinux system are

vagrant-lxc
vagrant-libvirt
virtualbox
    $ vagrant up --provider lxc
    OR
    $ vagrant up --provider libvirt
    OR
    $ vagrant up --provider virtualbox
Once it is finished, you should be able to connect to the vagrant environment through SSH and interact with Nomad:

    $ vagrant ssh
    [vagrant@nomad ~]$
    
# Opdracht 2 Documentatie ---> Team 16 
## Opgave:

Per 2 (overzicht), met behulp van vagrant de nomad cluster uit de eerste opdracht nu niet met bash maar met ansible of puppet op brengen. Maak hiervoor gebruik van de puppet of ansible provisioner.

Er dienen voor deze opdracht verschillende modules geschreven te worden als ook roles (en profiles) samen met een node manifest of play. Het gebruik van parameters en templates voor de configuraties waar nodig wordt ten zeerste aangeraden!

Verdeel het werk onderling, zodanig ieder zelf code schrijft en dit ook duidelijk wordt uit de git history.

Nomad en consul te werken zoals beoogd in de eerste opdracht! Er zal ook deze keer gekeken worden met behulp van een nomad job file of de cluster werkt zoals vooropgesteld.

## Plan van aanpak: 

Bij de start van deze opdracht hebben we de hele mappenstructuur overgenomen van ansible. 
Voor te beginnen hebben we een aantal service roles aangemaakt voor nomad, consul en docker. Deze service roles hebben we dezelfde structuur gegeven op basis van de service crond. Wanneer dit allemaal was uitgevoerd hadden we de default set-up voor ons en konden we beginnen met aanpassingen te doen aan alle bestanden. Hieronder ziet u een foto van onze mappenstructuur:

Foto van onze tree, met een korte uitleg per directory wat er in zit

Wij hebben het werk wat verdeeld onderling: Roel heeft de service roles docker en consul voor zijn rekening gehouden en Kobe heeft de service role nomad opgemaakt. We hebben voor elke service role defaults, tasks, templates en handlers geschreven. Hierna hebben onze vagrantfile gemodificeerd, waar we 2 client nodes en 1 server node opzetten. Zo konden we service roles controleren en foutcontrole op doen: door vagrant up te doen en te kijken als er eventueel fouten optreden bij het doorlopen van de verschillende stappen. ...


first step (moet op de 3 vms): sudo yum install -y yum-utils sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo sudo yum -y install consul sudo yum -y install nomad sudo yum -y install docker

config: /etc/nomad.d/nomad.hcl /etc/consul.d/consul.hcl

consul : ook nomad bind addres: 192.168.1.4 server:true systemctl start consul

echo newfile -> oldfile

-- nomad agent -config /vagrant/scripts/NomadServerConfig sudo su - service consul start service docker start service nomad start exit



We zijn begonnen met een kopie van de repo met ansible in.
We hebben eerst geprobeerd om dit allemaal te draaien in een ubuntu server.
Dit werkte niet omdat deze door virtualbox werd gehost en virtualbox nesting support.
Roel had al gehoord van zijn groepsgenoten van het project dat het niet zo moeilijk was om het op windows te draaien.
Er moet gewoon ansible_local gebruikt worden.
We zijn begonnen met docer-ce te installeren.
