data_dir = "/opt/nomad/data"
#bind_addr = "192.168.2.4"
bind_addr = "{{ GetInterfaceIP \"eth1\" }}"

server {
  enabled = true
  bootstrap_expect = 1
}
