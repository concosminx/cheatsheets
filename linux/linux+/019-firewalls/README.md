# firewalls

## access control list - ACL
- packet filtering firewall, captures all incoming and outgoing packages
- ACL defines which packages are allowed
- filters on packet origin (source), destination, ports and protocol
  - source: where the package originated; filter on
    - source IP address, source MAC address
  - destination: where the package is being sent, filter on
    - destination IP address
    - destination MAC address
  - ports, can filter on destionation or source ports
  - protocol, can filter on protocol TCP/UDP or protocol asociated with a port
- ACL defines also the actions a firewall can take
  - Accept - allows the packet to proceed
  - Reject - returns packet to source with error message
  - Drop - discards the packet with no response sent
  - Log - creates a log entry with information about the packet (Packet is neither allowed nor blocked)

## firewall operation types
- Stateless
  - faster, simpler
  - does not consider network connection status or traffic patterns
  - administrative overhead
- Statefull
  - tracks active network connections and network status
- Logging
  - increase the amount of logs
  
## Netfilter
- used by linux kernel
- can do: stateless/statefull packet filtering, network address and port translation, IP forwarding
- used by: firewalld and UFW

## iptables
- tables (types of rules) and chains (list of rules)
- **chains** 
  - PREROUTING - handles packets as soon as they come in
  - INPUT - handles packets destined for the local host (local sockets)
  - FORWARD - handles packets being routed through the system to another, remote system 
  - POSTROUTING - more handling for packets being sent to a remote system
  - OUTPUT - for handling/altering locally-generated packets that are outbound from the system
- **tables**
  - filter - allowing or rejecting packets
  - nat - network address translation, rules to change the addresses before they exit the chain
  - mangle - cnahge features of the packet before exiting the chain
  - raw - marks packets to opt-out of statefull connection tracking
  - security - applies mandatory access control, used by SELinux
- each chain has a **policy** value
  - Accept - pass the packet along to the next chain
  - Reject  - don't pass and send error message
  - Drop - don't pass and no message sent
  - Queue - sends packets to a userspace application to be evaluated - if no application available, drops packet

- `iptables` command
- `iptables -t <table> <command> <chain> <options>`
- examples:
  - `iptables -L` - lists all existing rules
  - `iptables -t filter -L` - listt all rules in the filter table and associated chains
  - `iptables -A input -s 0/0 -p http ACCEPT` - adds rule to allow all http protocol trafic
- save the rules `iptabless-save` 
- restore rules from file `iptables-restore`

## working with firewalld
- Red Hat-based distros
- uses D-Bus communication to reload rules instantaneously
- uses *zones*
  - `/usr/lib/firewalld/zones` - default dir
  - `/etc/firewalld/zones` - custom zones files
- predefined zones:
  - drop - drops all, no message
  - block - blocks all, and messages
  - public - for use in public areas where other systems on the network are not trusted
  - external - similor to public, used on external networks
  - dmz - similar to public
  - work - accepts select incoming network connections, more permisive than public
  - home - more permisive than work
  - internal - similar to work, but used on internal networks
  - trusted - accepts all network connections

### firewall-cmd command
- `firewall-cmd --runtime-to-permanent` - save runtime to permanent
- `firewall-cmd --permanent` - create the rules as permanent
- `sudo systemctl enable --now firewalld`
- `firewall-cmd --get-zones`
- `firewall-cmd --get-default-zone`
- `firewall-cmd --list-all`
- `firewall-cmd --set-default-zone=internal`
- `firewall-cmd --add-service=dns`
- `firewall-cmd --reload`


## ufw
- the Uncomplicated Firewall
- `/etc/default/ufw` - default policies
- `/etc/ufw` - custom rules
- persistent by default
- disabled by default
- commands
  - ufw disable - stops UFW and disables it from starting
  - ufw reset  - disables UFW and resets it to defaults
  - ufw reload 
  - ufw status - displays current state
  - `ufw allow <identifier>`
  - `ufw deny <identifier>`
  - `ufw reject <identifier>`
  - examples:
    - `ufw status verbose`
    - `ufw show added`
    - `ufw status numbered`
    - `ufw delete 6`

## IP forwarding
- from one interface to another interface
- perform network address translation or masquerading
- nat types
  - destination NAT
    - serverse behind a firewall that still need external access
    - DNAT rules live in the PREROUTING filter chain
  - source NAT
    - to send all internet network traffic through a single external IP
    - static, internal addresses mappet to a single machine with SNAT
    - SNAT rules live in the POSTROUTING filter chain
  - MASQUERADE
    - SNAT with dynamically assigned private IP addresses
- enable IP forwarding
  - IPv4
    - echo 1 > /proc/sys/new/ipv4/ip_forward
    - sysctl -w net.ipv4.ip_forward=1
  - IPv6
    - echo 1 > /proc/sys/new/ipv6/ip_forward
    - sysctl -w net.ipv6.conf.all.ip_forwarding=1

## dynamic rule set - DenyHosts
- protects against brute-force attacks on OpenSSH
- monitors sshd logs

## dynamic rule set - Fail2Ban
- generates dynamic rule set by monitoring system logs
- when bad login attempts or security threats are found fail2ban can:
  - update or add iptables/firewalld rules
  - add hosts to /etc/hosts.deny
- `/etc/fail2ban/jail.conf` - configuration file
  - bantime
  - maxretry
  - findtime
  - enabled
  - ignoreip - never ban
- example
  - `sudo apt install fail2ban`
  - `/etc/fail2ban/jail.conf`
  
## dynamic rule set - IPset
- a named set of IP addresses (or .. ports, MACs ...)
- ipset command
  - `ipset create <IPset name> <storage type>:<set type>`
  - `ipset -N <IPset name> <storage type>:<set type>`
  - `ipset -N BadIPs hash:net`
- IPs or ranges can be added to a set
  - `ipset add <IPset name> <address or range>`
  - `ipset -A <IPset name> <address or range>`
    - `ipset -A BadIPs 10.10.101.0/24`
- to remove
  - `ipset del <IPset name> <address or range>`
  - `ipset -D <IPset name> <address or range>`
- to remove the entire set
  - `ipset destroy <IPset name>`

## common application port configurations
- `/etc/services` - standard application services and the ports assigned to them by IANA
