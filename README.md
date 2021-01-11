# Opdracht 3 Documentatie ---> Team 16 
## Opgave:

Per 2 ( overzicht), met behulp van vagrant de nomad cluster uit de tweede opdracht monitoring opzetten op basis van metrics (prometheus, alertmanager, grafana)
Deze dienen allen als container te worden gestart op de nomad cluster. Ook de node-exporter dient als container te worden opgespint op ALLE nodes.

De setup dient te worden geconfigureerd zodanig je nomad/consul cluster gemonitord wordt alsook een extra zelf uit te kiezen applicatie (ook een nomad job waarvan je de metrics binnenhaalt)

De prometheus en alertmanager targets liefst dynamisch geconfigureerd zoals geillustreerd tijdens de les. Dashboards dienen te worden voorzien via grafana, de json export plaats je in je git repository zodanig ze kunnen worden geimporteerd tijdens de evaluatie.

Er dient van deze jobs niets automatisch te worden opgezet via vagrant up (mag wel) de nomad jobs dienen wel aanwezig te zijn in de git repository!

Tijdens het evaluatie moment dient er een vagrant destroy vagrant up te gebeuren waarna jullie stap voor de stap door de monitoring jobs lopen, manueel starten, eventuele grafana configuratie toepassen en de dashboards inladen.


## Plan van aanpak: 
Bij deze opdracht maken we gebruik van 3 vm's, namelijk:

* Server
* Client1
* Client2

```bash
$ vagrant up --provision virtualbox

```
Het bovenstaande commando zorgt ervoor, dat alle vm's worden opgestart die in de vagrantfile worden besproken met als provider Virtualbox.
Weergave van de vagrant file:
```bash
# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

# config.vbguest.auto_update = false

  config.vm.provider :virtualbox do |virtualbox, override|
    virtualbox.customize ["modifyvm", :id, "--memory", 2048]
  end

  config.vm.define "server" do |server|
    server.vm.box = "centos/7"
    server.vm.hostname = "server"
	  server.vm.network "private_network", ip: "192.168.3.4", virtualbox_internet: "mynetwork"
	  server.vm.network "forwarded_port", guest: 4646, host: 4646, auto_correct: true, host_ip: "127.0.0.1"
	  server.vm.network "forwarded_port", guest: 8500, host: 8500, auto_correct: true, host_ip: "127.0.0.1"
    server.vm.network "forwarded_port", guest: 9090, host: 9090, auto_correct: true, host_ip: "127.0.0.1"

    server.vm.provision "ansible_local" do |ansible|
      ansible.config_file = "ansible/ansible.cfg"
      ansible.playbook = "ansible/plays/server.yml"
      ansible.groups = {
        "servers" => ["server"],
      }
	  ansible.host_vars = {}
    end
  end

  config.vm.define "client1" do |client1|
    client1.vm.box = "centos/7"
    client1.vm.hostname = "client1"
	  client1.vm.network "private_network", ip: "192.168.3.5", virtualbox_internet: "mynetwork"
    
    client1.vm.provision "ansible_local" do |ansible|
      ansible.config_file = "ansible/ansible.cfg"
      ansible.playbook = "ansible/plays/client.yml"
      ansible.groups = {
        "clients" => ["client1"],
      }
	  ansible.host_vars = {}
    end
  end

  config.vm.define "client2" do |client2|
    client2.vm.box = "centos/7"
    client2.vm.hostname = "client2"
    client2.vm.network "private_network", ip: "192.168.3.6", virtualbox_internet: "mynetwork"
    
    client2.vm.provision "ansible_local" do |ansible|
      ansible.config_file = "ansible/ansible.cfg"
      ansible.playbook = "ansible/plays/client.yml"
      ansible.groups = {
        "clients" => ["client2"],
      }
	  ansible.host_vars = {}
    end
  end  
end
``` 
De vagrantfile overloopt de volgende instellingen:
* Het meegeven van het type provider, waarop de verschillende vm omgevingen op zouden moeten draaien.
* Ook het besturingssysteem wordt meegegeven en er wordt aan port forwarding gedaan (Nomad, Consul en Prometheus).
* Elke Vm krijgt een unieke statische Ip vanuit hetzelfde ip subnet.
* Iedere Vm runt een Ansible playbook

Elke vm bevat de volgende roles:
* Nomad
* Consul
* Docker
* Node_exporter (clients)
* Nomad_jobs (server)

Weergave playbook van de server:
```bash
---
- name: playbook for server vm
  hosts: servers
  become: yes

  roles:
    - role: software/nomad
    - role: software/consul
    - role: software/docker
    - role: software/node_exporter
    - role: software/nomad_jobs
```
Weergave playbook van de clients:
```bash
---
- name: playbook for client vm
  hosts: clients
  become: yes

  roles:
    - role: software/nomad
    - role: software/consul
    - role: software/docker
    - role: software/node_exporter
```
De roles Nomad, Consul en Docker documentatie vindt u terug in onze vorige opdracht, deze betreffende roles halen we hier niet meer aan.
De bijkomende roles bij deze opdracht zijn:

###Node_exporter
####Tasks









## Bijlagen:

Voor handler: https://docs.ansible.com/ansible/latest/collections/ansible/builtin/lineinfile_module.html

Voor template:
https://docs.ansible.com/ansible/latest/collections/ansible/builtin/template_module.html
