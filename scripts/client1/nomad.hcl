data_dir = "/opt/nomad/data"
#bind_addr = "192.168.2.5"
bind_addr = "{{ GetInterfaceIP \"eth1\" }}"
name = "node1"

client {
  enabled = true
  servers = ["192.168.2.4"]
}
