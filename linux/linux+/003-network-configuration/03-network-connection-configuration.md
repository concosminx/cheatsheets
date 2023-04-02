#centos | ubuntu

## show the IP address 
`ip addr show`

## change the IP address temporarly
`ip addr add 192.168.1.15 dev enp0s3`

## modify status
- `ip link set enp0s3 down`
- `ip link show`
- `ip link set enp0s3 up`

## ping command
- `ping www.google.com`
- `ping -c 4 wwww.google.com`

## ethtool 
- `ethtool enp0s3`
- `ethtool enp0s3 --autoneg off`

#ubuntu 

## wirless network configuration
`iwconfig`
