# see 2 or more network interfaces as one

## modes
 
- Aggregation #4: all combined as one "pipe"
- Active/Pasive #1: one up, one available (pasive)
- Load Balancing #5: network trafic is shared between all interfaces

## configuring bonding centos
- `/etc/sysconfig/network-scripts/ifconfig-<bond name>`
- configure the bond with the name and other settings
- modify the individual interfaces files and add them to the bond

## configuring bonding ubuntu
- `/etc/network/interfaces`
- or modify the netplan YAML file to create the bond
- create a bond in NetworkManager through `nmcli` or `nmtui`
