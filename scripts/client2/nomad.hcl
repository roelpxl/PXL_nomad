data_dir = "/opt/nomad/data"
#bind_addr = "192.168.2.6"
bind_addr ={{  GetInterfaceIP \"eth1\" }}
name = "node2"

client {
  enabled = true
  servers = ["192.168.2.4"]
}
