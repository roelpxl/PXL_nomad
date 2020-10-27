data_dir = "/opt/consul"

#bind_addr = "192.168.2.5"
bind_addr ={{  GetInterfaceIP \"eth1\" }}

client_addr= "0.0.0.0"
ui = true
server = false
retry_join = ["192.168.2.4"]
