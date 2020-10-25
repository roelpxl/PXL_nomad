
data_dir = "/opt/consul"

bind_addr = "192.168.1.5"
advertise_addr = "192.168.1.5"

ui = true

server = false

retry_join = ["192.168.1.4"]


# encrypt
# Specifies the secret key to use for encryption of Consul network traffic. This key must
# be 32-bytes that are Base64-encoded. The easiest way to create an encryption key is to
# use consul keygen. All nodes within a cluster must share the same encryption key to
# communicate. The provided key is automatically persisted to the data directory and loaded
# automatically whenever the agent is restarted. This means that to encrypt Consul's gossip
# protocol, this option only needs to be provided once on each agent's initial startup
# sequence. If it is provided after Consul has been initialized with an encryption key,
# then the provided key is ignored and a warning will be displayed.
#encrypt = "..."

# retry_join
# Similar to -join but allows retrying a join until it is successful. Once it joins
# successfully to a member in a list of members it will never attempt to join again.
# Agents will then solely maintain their membership via gossip. This is useful for
# cases where you know the address will eventually be available. This option can be
# specified multiple times to specify multiple agents to join. The value can contain
# IPv4, IPv6, or DNS addresses. In Consul 1.1.0 and later this can be set to a go-sockaddr
# template. If Consul is running on the non-default Serf LAN port, this must be specified
# as well. IPv6 must use the "bracketed" syntax. If multiple values are given, they are
# tried and retried in the order listed until the first succeeds. Here are some examples:
#retry_join = ["consul.domain.internal"]
#retry_join = ["10.0.4.67"]
#retry_join = ["[::1]:8301"]
#retry_join = ["consul.domain.internal", "192.168.1.4"]
# Cloud Auto-join examples:
# More details - https://www.consul.io/docs/agent/cloud-auto-join
#retry_join = ["provider=aws tag_key=... tag_value=..."]
#retry_join = ["provider=azure tag_name=... tag_value=... tenant_id=... client_id=... subscription_id=... secret_access_key=..."]
#retry_join = ["provider=gce project_name=... tag_value=..."]
