# security best practices

## boot security
- physical security
- BIOS/UEFI - are secured with a password
- setting a boot loader password
  - `sudoedit /etc/grub.d/10_linux`
  - remove `--unrestricted` from that file
  - `sudo grub2-setpassword` to set a password
  - `sudo cat /boot/grub2/user.cfg` we can see the hashed password here
  - `sudo grub2-mkconfig -o /boot/grub2/grub.cfg`
  - restart the system

## multifactor authentication 
- MFA, 2 of 
  - something you know
  - something you have
  - something you are
- OTP
  - one time password (something that you have)
  - physical OTP or software OTP
- tokens (CAC/PIV cards)
- biometrics (something you are): fingerprint, facial recognition, retina or iris scanner

## remote authentication options
- validating user accounts
- RADIUS - Remote Authentication Dial-In User Service
  - used for switches (now)
  - uses Ports 1812 and 1813
- TACACS+ 
  - uses port 49
  - AAA service

## LDAP
- implementation of X.500 directory service
- defines database objects: usernames and passwords and devices
- X.500 specififies the structure
- database can be distributed
- vendor neutral
- most secure version LDAP v3 (TLS)
- ports: 389 with TLS and 636 without

## Kerberos
- released for single sign-on (SSO)
- components
  - AS - authentication server
  - KDS - Key Distribution Center 
    - issues a ticket-granting ticket (encrypted and has a time limit)
  - TGS - Ticket-Granting Service 
- tools
  - kinit - used to obtain an individual ticket
  - klist - used to vie the tickets contained in the cache
  
## disabling root login
- `sudoedit /etc/ssh/sshd_config`
- `/Permit`
- `PermitRootLogin no`
- `sudo systemctl restart sshd`
- `sudo systemctl status sshd`
  
## PKI and enforcing password-less login
- `whoami`
- `sudoedit /etc/ssh/sshd_config`
- change `PasswordAuthentication` to no
- change `PubkeyAuthentication` to yes
- `systemctl restart sshd`
- `systemctl status sshd`
- `ssh user1@ubuntu`
- `ssh-keygen -t rsa -b 4096 -C "user1@adomain.com"`
- `ssh-copy-id user1@ubuntu`
- `cat /etc/home/user1/.ssh/id_rsa.pub`
- copy the key to server
- `cd /home/user1/.ssh/` (for that specific user)
- `nano authorized_keys` and paste the public key
- cache the private key on client: eval `ssh-agent`, ssh-add, enter the passphrase key

## croot jail service
- a service that has been limited to a portion of filesystem
- runs in a new root directory structure (changes the root, hence chroot)
- `chroot <new_root_dir> <service>`
  - after this is done, commands running in the chroot will only reference files and directories in this new root dir.
  - the service or app things is running in the real filesystem so any needed resources it needs must be copied to the new root directory


## enforcing no shared ID's
- `/etc/passwd` - column 3
- `/etc/group` - column 3

## denying hosts access
- avoid brute force attacks
- `/etc/hosts.deny` - a block list
  - utilities:
    - DebyHosts - automatically updates hosts.deny and firewall (iptables)
    - Fail2Ban - similar, and also monitors auth logs:
      - SSH via /var/log/auth.log
      - FTP via /var/log/vsftpd.log
      - Web Services via /var/log/apache2/access.log
      - Comes pre-configured and is tunnable

## OS and application partitioning 
- examples
  - /usr and /opt hold application data (can have separate partitions)
  - /home (can be also a separate partition)
  - /var (using log and spool data)
  - /boot (separate boot files)
  - remaining system data in root folder (/)

## changing the default ports
- example change the ssh port
  - `sudoedit /etc/ssh/sshd_config` 
  - search for port and change it to 49152
  - `systemctl restart sshd`
  - `ssh -p 49152` - from the client side

## removing the non secure services
- FTP uses ports 21 and 22
- replaced by:
  -  SFTP - over SSH (port 22) - recommended
  -  FTPS - FTP using TLS/PKI (variable ports)
- check if the FTP is running:
  - `netstat -tuna | grep ":21"`
  - `pgrep ftpd`
  - `systemctl list-units --type=service | grep ftp`
- Telnet 
  - is replaced by `ssh`
  - port 23
- Mail services
  - `sendmail` and `postfix`
  - port 25

## enable SSL/TLS
- it's not a good idea to send data in plain text
- SSL (Secure Socket Layer) was replaced by TLS (Transport Layer Security)
- can be used by HTTPS / LDAP / VPN / FTPS

## enabling auditd
- provides a more thorough security auditing system
- monitors:
  - files and directory access; commands run by users;
  - system calls mady by applications and services;
  - network access by users
  - network connection attempts made externally
- rule types:
  - system rules - log system calls made by applications
  - file system rules - log access to files and directories
  - control rules - rules that modify the way auditd behaves
- `auditctl` - to define rules (transient)
- `/etc/audit/audit.rules` - persistent rules
- define a separate partition or implement log rotation
  
## CVE monitoring 
- CVE - Common Vulnerabilities and Exposure

## restricting USB devices
- `modprobe` utility
- `/etc/modprobe.d` contains `blacklist.conf` with module that are blocked from loading

## disk encryption
- disk or block device encryption
- works at the kernel level
- LUKS - Linux Unified Key Setup
- uses module dm-crypt
- cryptmount (doesn't require sudo right)
- cryptsetup 

## restricting cron access 
- `/etc/cron.allow`, `/etc/at.allow`
  - if exists, only users in the file and root user can schedule jobs
- `/etc/cron.deny`, `/etc/at.deny`
  - users in the deny file are prevented from scheduling jobs
- if neither file exists, only root can manage cron

## disable Ctrl + Alt + Del 
- in Linux it REBOOTS THE SYSTEM
- `systemctl list-units --type=target`
- `sudo systemctl mask ctrl-alt-delete.target`


## adding banner messages
- `/etc/login.warn` or `/etc/issue` (warning/legal disclaimer) - before login
  - `sudoedit /etc/issue` 
- `/etc/motd` (Message of the Day) - after login







