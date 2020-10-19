data_dir = "/opt/nomad/data"
bind_addr = "192.168.1.5"

client {
  enabled = true
  servers = ["192.168.1.4"]
}
