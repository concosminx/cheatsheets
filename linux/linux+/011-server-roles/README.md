# server roles

## 1. NTP
- NTP (Network Time Protocol)
- an NTP client system receives time from an NTP Server
- uses port *123*
- common used `pool.ntp.org`

### configure in CentOS
- is installed by default
- `systemctl status chronyd`
- if not installed: `dnf install chrony`, and `systemctl enabble --now chronyd`
- `vim /etc/chrony.conf` - allow NTP client access from local network
- `systemctl restart chronyd`
- `systemctl status firewalld` - check if the firewall is up
- `firewall-cmd --permanend --add-service=ntp` - add a rule
- `firewall-cmd --reload` - reload firewall

### configure in ubuntu
- `app install ntp` - install the service
- `nano /etc/ntp.conf` - change the upstream NTP servers
- `systemctl restart ntp` - restart the service
- `systemctl status ufw` - check the firewall
- `ufw allow ntp` - add a rule

## 2. SSH
- Secure SHell (replaced telnet, ftp (sftp), rcp (scp), rsh)
- default uses port `22`

### configure ssh in ubuntu
- `apt install openssh-server`
- `systemctl enable ssh`, `start`, `status`
- `/etc/ssh/ssh_config` - general client configuration
- `/home/user/.ssh` - user client configuration
- `/etc/ssh/sshd_config` - server configuration

## 3. Web Server
- Apache (or https) vs. NGINX

### Apache Web Server
- centos
  - `yum install httpd` 
  - `rpm -ql httpd | less` - see the installed files
  - `less /etc/httpd/conf/httpd.conf` - configuration file
  - `systemctl start httpd` - start the service
  - `systemctl status httpd` - check the status
- ubuntu
  - `apt install apache2`
  - `dpkg -L apache2 | less` - see the installed files
  - `less /etc/apache2/apache2.conf` - configuration file
  - `ls /etc/apache2` - see other configuration files
  - `systemctl status apache2` - see the servuce status 
  - `ufw app list` - see available
  - `ufw allow "Apache"` - add a firewall rule

### NGINX
- centos
  - `dnf install nginx`
  - `rpm -ql nginx | less`
  - `less /etc/nginx/nginx.conf`
  - `systemctl enable --now nginx`
  - `systemctl status nginx`
- ubuntu
  - `apt install nginx`
  - `dpkg -L nginx | less`
  - `less /etc/nginx/nginx.conf` and `ls /etc/nginx/sites-available`
  - `systemctl status nginx`
  - `ufw app list` - app list
  - `ufw allow "Nginx HTTP"` - add a firewall rule


## 4. Certificate Authority Server
- (CA) - digital certificates to validate the identity of the server

## 5. Name Server
- DNS (Domain Name Server) translates IP addresses to host name
- uses port *53*
- BIND - Berkley Internet Name Domain (package used to provide DNS name server services)
- `/etc/resolv.conf`
- centos
  - `dnf install bind` - install the service
  - `rpm -ql bind | less` - check the installed files
  - `less /etc/named.conf` - configuration file
- ubuntu
  - `apt install bind9 bind9-doc dnsutils`
  - `dpkg -L bind9 | less`
  - `less /etc/bind/named.conf`

## 6. DHCP
- Dynamic Host Control Protocol - assigns IP adresses to devices
- uses ports 67 (input), 68 (output) - DORA (discovery, offer, request, acknowledgment)
- centos
  - `dnf install dhcp-server`
  - `ip addr list`
  - `less /etc/dhcp/dhcpd.conf` 
  - `systemctl enable --now dhcpd`
  - `systemctl status firewalld`
  - `firewall-cmd --add-service=dhcp --permanent && firewall-cmd --reload` - add a rule and reload
- ubuntu
  - `apt install isc-dhcp-server`
  - `ip addr list`
  - `less /etc/dhcp/dhcpd.conf`
  - `systemctl enable --now isc-dhcp-server`

## 7. File Server
- two server packages: NFS (port 2049) and Samba (port 137-139, 445)
- SMB - Server Message Block

### NFS instalation
- centos
  - `systemctl enable --now nfs-server`
  - `nano /etc/exports` - configuration file
    ```sh
    /mnt/nfsExp/nfs 192.168.1.0/24(rw,no_root_squash)
    ```
  - `exportfs -rav`
- ubuntu 
  - `apt install nfs-kernel-server`
  - `systemctl enable --now nfs-server`
  - `nano /etc/exports`
  ```sh
  /mnt/nfsExp/nfs 192.168.1.0/24(rw,no_root_squash)
  ```
  - `exportfs -rav`

### Samba instalation
- centos
  - `dns install samba samba-client`
  - `systemctl enable --now {smb,nmb}` - enable both
  - `systemctl status smb nmb` - check the status
  - `nano /etc/samba/smb.conf` - configuration
  ```sh
  [smbShare]
        path = /mnt/smbExp/smb
        guest ok = no
  ```
  - `testparm` - test configuration
  - `systemctl restart {smb,nmb}`
- ubuntu 
  - `apt install samba`
  - `systemctl enable --now {smbd,nmbd}` - enable both
  - `systemctl status smbd nmbd` - check the status
  - `nano /etc/samba/smb.conf` - configuration
  - `bash -c grep -v -E "^#|^;" /etc/samba/smb.conf.bak | grep . > /etc/samba/smb.conf` - remove comments
  

## 8. Authentication server
- NIS - Network Information System (ports 111, 714,711)
- Kerberos (port 88)
- LDAP - Lightwight Directory Acess Protocol [OpenLDAP most commonly]
  - ports: 389, 636
  - distributed (synced) between LDAP server
- RADIUS - Remote Auth. Dial-In User Service (ports: 1645, 1646; 1812, 1813; 7082); still used in wireless network
  
## 9. Proxy server
- monitor and filter trafic; bypass filter; cache static data;
- examples: Squid and NGINX
- generally on port 8080
- centos 
  - `dnf install squid`
  - `systemctl enable --now squid`
  - `nano /etc/squid/squid.conf`
  - `firewall-cmd -add-service=squid --permanent && firewall-cmd --reload`
- ubuntu
  - `apt install squid`

## 10. Log server
- used a centralized location do record logs
- remote logging on port 514
- `rsyslogd` and `journald`
- `rsyslogd` stores log files `/var/log` in plain text
- `journald` stores log files in `/var/log` in binary format
- centos
  - `nano /etc/rsyslog.conf` - configuration 
  - check docs for setup
  - `firewall-cmd --add-port=514/udp --permanent`
  - `firewall-cmd --add-port=514/tcp --permanent`
  - `systemctl restart rsyslog.service`
  - `journalctl -f` - follow ... 
  - `nano /etc/systemd/journald.conf`

## 11. Container server

## 12. VPN server
- remotely connect to the company network
- VPN creates a secure p2p tunner between the client and the server
- can use symmetric encryption / or SSL/TLS asymmetric encryption
- `OpenVPN` 

## 13. Monitoring server
- `Nagios` and `Cacti` - system activity
- `wireshark` and `tcpdump` - network activity
- SNMP - Simple Network Management Protocols (~ traps)
- `top` - all running process 
- `free` - check memory
- `ps aux` - check processes

# 14. Database server
- install postgreSQL (centos)
  - `dnf module list postrgresql`
  - `dnf module enable postrgresql:12` - makes this version default
  - `dnf install postgresql-server`
  - `postgresql-setup --initdb`
  - `systemctl enable --now postresql`
- install postgreSQL (ubuntu)
  - `apt install postrgresql postrgresql-contrib`

# 15. Print server
- CUPS

# 16. Mail server
- MTA - Mail Transfer Agent
- SMTP - runs on port *25*
- centos
  - `dnf install postfix`
  - `less /etc/postfix/main.cf`
    - configure the hostname
    - configure the domain
    - setup the network
  - `systemctl restart postfix`
- ubuntu
  - `DEBIAN_PRIORITY=low apt install postfix` - will open an interactive installer
