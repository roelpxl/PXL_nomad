data_dir = "/opt/nomad/data"
bind_addr = "192.168.1.5"

client {
  enabled = true
  servers = ["192.168.1.4:4647"]
}

advertise{
  http = "192.168.1.5:4646"
  rpc = "192.168.1.5:4647"
  serf = "192.168.1.5:4648"
}
