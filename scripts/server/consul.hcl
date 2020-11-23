data_dir = "/opt/consul"

client_addr = "0.0.0.0"
#bind_addr = "192.168.2.4"
bind_addr = "{{ GetInterfaceIP \"eth1\" }}"

ui = true

server = true

bootstrap_expect=1
