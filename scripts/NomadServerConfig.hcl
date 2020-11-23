data_dir = "/opt/nomad/data"
bind_addr = "192.168.2.4"

server {
  enabled = true
  bootstrap_expect = 1
}

#addresses{
#  http = "192.168.1.4"
#  rpc = "192.168.1.4"
#  serf = "192.168.1.4"
#}


#advertise{
#  http = "192.168.1.4:4646"
#  rpc = "192.168.1.4:4647"
#  serf = "192.168.1.4:4648"
#}
