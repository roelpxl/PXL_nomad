data_dir = "/opt/nomad/data"
bind_addr = "192.168.1.4"

server {
  enabled = true
  bootstrap_expect = 1
}

advertise{
  http = "192.168.1.4:4647"
  rpc = "192.168.1.4:4646"
  serf = "192.168.1.4:4648"
}
