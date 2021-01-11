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

### Node_exporter
#### Node_Exporter Handlers
```bash
---
- name: Started Node_exporter
  service:
    name: node_exporter
    state: started
```
#### Node_Exporter Tasks
```bash
---
- name: Download node_exporter
  get_url:
    url: https://github.com/prometheus/node_exporter/releases/download/v1.0.1/node_exporter-1.0.1.linux-amd64.tar.gz
    dest: /home/vagrant
    mode: '0776'
    

- name: Extract node_exporter
  unarchive:
    src: /home/vagrant/node_exporter-1.0.1.linux-amd64.tar.gz
    dest: /home/vagrant

- name: Move node_exporter
  command: mv /home/vagrant/node_exporter-1.0.1.linux-amd64/node_exporter /usr/local/bin/

- name: Node_exporter .service file
  template: 
    src: node_exporter.service.sh.j2
    dest: /etc/systemd/system/node_exporter.service

- name: Start node_exporter
  service:
    name: node_exporter
    state: started
```
#### Node_Exporter templates
```bash
[Unit]
Description=Node Exporter
After=network.target
 
[Service]
User=vagrant
Group=vagrant
Type=simple
ExecStart=/usr/local/bin/node_exporter
 
[Install]
WantedBy=multi-user.target
```
### Nomad_jobs
#### Nomad_jobs handlers
```bash
---
- name: Start prometheus
  shell: nomad job run -address=http://{{server_ip}}:4646 /opt/nomad/prometheus.hcl || exit 0

- name: Start grafana
  shell: nomad job run -address=http://{{server_ip}}:4646 /opt/nomad/grafana.hcl || exit 0

- name: Start alertmanager
  shell: nomad job run -address=http://{{server_ip}}:4646 /opt/nomad/alertmanager.hcl || exit 0

- name: Start webserver
  shell: nomad job run -address=http://{{server_ip}}:4646 /opt/nomad/webserver.hcl || exit 0
```
#### Nomad_jobs tasks
```bash
---
- name: Create a directory for Prometheus.yml
  file:
    path: /opt/prometheus
    state: directory
    mode: '0755'

- name: Create a directory for alertmanager rules
  file:
    path: /opt/alertmanager
    state: directory
    mode: '0755'

- name: alertmanager infrastructure rules template
  template: 
    src: infrastructure.hcl.sh.j2
    dest: /opt/alertmanager/infrastructure.rules

- name: Prometheus.yml template
  template: 
    src: prometheus.yml.sh.j2
    dest: /opt/prometheus/prometheus.yml

- name: Prometheus template
  template: 
    src: jobs.hcl.sh.j2
    dest: /opt/nomad/prometheus.hcl
  vars:
    job_name: prometheus
    job_image: prom/prometheus:latest
    job_port: 9090
  notify: Start prometheus

- name: Grafana template
  template: 
    src: jobs.hcl.sh.j2
    dest: /opt/nomad/grafana.hcl
  vars:
    job_name: grafana
    job_image: grafana/grafana:latest
    job_port: 3000
  notify: Start grafana

- name: Alertmanager template
  template: 
    src: jobs.hcl.sh.j2
    dest: /opt/nomad/alertmanager.hcl
  vars:
    job_name: alertmanager
    job_image: prom/alertmanager:latest
    job_port: 9093
  notify: Start alertmanager

- name: webserver template
  template: 
    src: webserver.hcl.sh.j2
    dest: /opt/nomad/webserver.hcl
  notify: Start webserver

- name: webserver template
  template: 
    src: rules.yml.sh.j2
    dest: /opt/prometheus/rules.yml
  notify: Start webserver
```
#### Nomad_jobes templates (default template)
```bash
job "{{job_name}}" {
	datacenters = ["dc1"] 
	type = "service"

	group "{{job_name}}" {
		count = 1
		network {
			port "{{job_name}}_port" {
			to = {{job_port}}
			static = {{job_port}}
			}
		}
		task "{{job_name}}" {
			driver = "docker"
			config {
				image = "{{job_image}}"
				ports = ["{{job_name}}_port"]
				logging {
					type = "journald"
					config {
						tag = "{{job_name}}"
					}
				}
			
			}
			service {
				name = "{{job_name}}"
				tags = ["metrics"]		
			}
		}
	}
}
```
#### Nomad_jobes templates (Prometheus.hcl)
```bash
job "{{job_name}}" {
	datacenters = ["dc1"] 
	type = "service"

	group "{{job_name}}" {
		count = 1
		network {
			port "{{job_name}}_port" {
			to = {{job_port}}
			static = {{job_port}}
			}
		}
	  task "{{job_name}}" {
		driver = "docker"
		config {
			image = "{{job_image}}"
			ports = ["{{job_name}}_port"]
			logging {
				type = "journald"
				config {
					tag = "{{job_name}}"
				}
			}
        volumes = [
          "/opt/prometheus/:/etc/prometheus/"
        ]
        args = [
          "--config.file=/etc/prometheus/prometheus.yml",
          "--storage.tsdb.path=/prometheus",
	  "--web.enable-lifecycle",
          "--web.console.libraries=/usr/share/prometheus/console_libraries",
          "--web.console.templates=/usr/share/prometheus/consoles",
          "--web.enable-admin-api"
        ]
		}
		service {
			name = "{{job_name}}"
		}
	  }
	}
}
```
#### Nomad_jobes templates (Prometheus.yml)
```bash
global:                                       
  scrape_interval:     5s                     
  evaluation_interval: 5s                     

alerting:
  alertmanagers:
    - consul_sd_configs:
      - server: '192.168.3.4:8500'
        services: ['alertmanager']
    - relabel_configs: 
        - source_labels: [__address__]          
          action: replace                       
          regex: ([^:]+):.*                     
          replacement: $1:9093              
          target_label: __address__

rule_files:
 - rules.yml

scrape_configs:                               
                                              
  - job_name: 'nomad_metrics'                 
                                              
    consul_sd_configs:                        
    - server: '192.168.3.4:8500'             
      services: ['nomad-client', 'nomad']     
                                              
    relabel_configs:                          
    - source_labels: ['__meta_consul_tags']   
      regex: '(.*)http(.*)'                   
      action: keep                            
                                              
    scrape_interval: 5s                       
    metrics_path: /v1/metrics                 
    params:                                   
      format: ['prometheus']                  
  - job_name: 'node_exporter'                 
    consul_sd_configs:                        
      - server: '192.168.3.4:8500'           
        services: ['nomad-client']            
    relabel_configs:                          
      - source_labels: [__meta_consul_tags]   
        regex: '(.*)http(.*)'                 
        action: keep                          
      - source_labels: [__meta_consul_service]
        target_label: job                     
      - source_labels: [__address__]          
        action: replace                       
        regex: ([^:]+):.*                     
        replacement: $1:9100                  
        target_label: __address__  
        
  - job_name: 'webserver'
    consul_sd_configs:
    - server: '192.168.3.4:8500'
      services: ['webserver']
    metrics_path: /metrics
  
  - job_name: 'alertmanager'
    consul_sd_configs:
      - server: '192.168.3.4:8500'
        services: ['alertmanager']
    relabel_configs:
      - source_labels: [__meta_consul_service]
        target_label: job
      - source_labels: [__address__]          
        action: replace                       
        regex: ([^:]+):.*                     
        replacement: $1:9093              
        target_label: __address__

    scrape_interval: 5s
    metrics_path: /metrics
    params:
      format: ['prometheus']
```
#### Nomad_jobs templates (Webserver.hcl (Extra applicatie/server job))
```bash
job "webserver" {
  datacenters = ["dc1"]

  group "webserver" {
    task "server" {
      driver = "docker"
      config {
        image = "hashicorp/demo-prometheus-instrumentation:latest"
      }

      resources {
        cpu = 500
        memory = 256
        network {
          mbits = 10
          port  "http"{}
        }
      }

      service {
        name = "webserver"
        port = "http"

        tags = [
          "testweb",
          "urlprefix-/webserver strip=/webserver",
        ]

        check {
          type     = "http"
          path     = "/"
          interval = "2s"
          timeout  = "2s"
        }
      }
    }
  }
}
```
## Teamwork
We hebben samen deze opdracht tot stand gebracht en evenveel werk geleverd.
