# troubleshoot

## network configuration
- `/etc/sysconfig/network-scripts` - contos
- `/etc/netplan` - ubuntu
- `nmcli`
- `ip`

## troubleshoot network issues
- `netstat`
  - see the open ports
  - `netstat -au` - shows all UDP ports
  - `netstat -r` - routing information
- `ss`
  - similar with netstat
  - `ss -s`

## troubleshoot network latency
- `mtr`
  - `mtr www.google.com`
- `traceroute`
  - `traceroute www.google.com` 
- `nc` - netcat used to perform tests
- `ping`
- `tracepath wwww.google.com`

## network performance
- `iftop` - graph of the network bandwith
  - `ip link show`
  - `which iftop`
  - `sudo dnf install -y iftop iperf`
  - `sudo iftop enp0S3`
- `iperf` - peform network throughput tasks

## name resolution commands
- `dig`
  - `dig google.com a`
  - `dig google.com mx`
  - `dig google.com ns`
- `nslookup`
- `host`  

## network security commands
- `ipset`
  - `ipset create BadIPs hash:net`
  - `ipset list`
  - `ipset add BadIPs 10.10.10.1/24`
- `whois`
  - `whois badips.com`


## network mapping and protocol analyzers
- `tcpdump -i enp0S3 >> /home/user/Desktop/capture.txt 2>&1`
- `nmap -sV <ip>`

## disk space monitoring
- `df`
- `du -hx --max-depth=1 /`

## disk latency 
- `ioping`
  - `ioping . -c 100`
- `iostat`
  - `iostat` - status since the system boot up
  - `iostat -dh`

## storage repair
- `fsck` | `xfs_repair`
- `smartctl`
- `partprobe`

## CPU monitoring tools
- `/proc/cpuinfo`
- `uptime`
- `iostat -c 2 5` - displays the avg-cpu every 2 seconds, 5 times
- `sar`

## memory monitoring
- `/proc/meminfo`
- OOM Killer
- swapping 
  - `mkswap /dev/<partition>`
  - `swapon /dev/<partition>`
  - `swapoff /dev/<partition>`
- `free`
- `vmstat -s` - column format

