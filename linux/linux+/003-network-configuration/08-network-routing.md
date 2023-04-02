# display routing information 

- `route` and `netstat -r` display a routing table
- `route -n` displays destination numerically
- `netstat -r` displays different column info
- `ip route show` is a collapsed output

# route command 

- `route` displays the routing table 
- `route add|delete <target> gw <ip address>`
- changes are not persistent

# ip command

- `ip route add <target> via <gatewaty> dev <device>` add a route
- `ip route tel <target>` delete a route
- changes are not persistent

# how to do persistence in centos 

- enter a gateway line in the interface file `/etc/sysconfig/network-scripts/ifcfg-<interface>`
- or create a route file in `/etc/sysconfig/network-scripts/route-<interface>`

# how to do persistence in ubuntu

- enter a routes section in the netplan YAML config `/etc/netplan/<config>.yaml`
- use `nmcli` or `nmtui`
