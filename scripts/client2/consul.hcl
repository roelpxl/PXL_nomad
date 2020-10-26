datacenter = "my-dc-1"

# data_dir
# This flag provides a data directory for the agent to store state. This is required
# for all agents. The directory should be durable across reboots. This is especially
# critical for agents that are running in server mode as they must be able to persist
# cluster state. Additionally, the directory must support the use of filesystem
# locking, meaning some types of mounted folders (e.g. VirtualBox shared folders) may
# not be suitable.
data_dir = "/opt/consul"

# client_addr
# The address to which Consul will bind client interfaces, including the HTTP and DNS
# servers. By default, this is "127.0.0.1", allowing only loopback connections. In
# Consul 1.0 and later this can be set to a space-separated list of addresses to bind
# to, or a go-sockaddr template that can potentially resolve to multiple addresses.
client_addr = "0.0.0.0"
bind_addr = "192.168.2.6"
retry_join = ["192.168.2.4"]
# ui
# Enables the built-in web UI server and the required HTTP routes. This eliminates
# the need to maintain the Consul web UI files separately from the binary.
ui = true

# server
# This flag is used to control if an agent is in server or client mode. When provided,
# an agent will act as a Consul server. Each Consul cluster must have at least one
# server and ideally no more than 5 per datacenter. All servers participate in the Raft
# consensus algorithm to ensure that transactions occur in a consistent, linearizable
# manner. Transactions modify cluster state, which is maintained on all server nodes to
# ensure availability in the case of node failure. Server nodes also participate in a
# WAN gossip pool with server nodes in other datacenters. Servers act as gateways to
# other datacenters and forward traffic as appropriate.
server = false
