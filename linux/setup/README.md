Table of contents

- [Check the os version](#check-the-os-version)
- [Create a new user](#create-a-new-user)
- [Change the ssh port](#change-the-ssh-port)
  - [Check if the ssh is running](#check-if-the-ssh-is-running)
  - [Backup current configuration](#backup-current-configuration)
  - [Change ssh service port](#change-ssh-service-port)
  - [Allow new ssh port on SELinux](#allow-new-ssh-port-on-selinux)
  - [Open ssh port on firewalld](#open-ssh-port-on-firewalld)
  - [Restart sshd service](#restart-sshd-service)
- [Setting up firewall](#setting-up-firewall)
  - [Check the current status](#check-the-current-status)
  - [Firewall instalation](#firewall-instalation)
  - [Firewall operations](#firewall-operations)
  - [Defining a service](#defining-a-service)
  - [Creating your own zones](#creating-your-own-zones)
  - [Migrate from CentOS-8 to Rocky](#migrate-from-centos-8-to-rocky)
  - [Create user with sudo and group](#create-user-with-sudo-and-group)


----------
# Check the os version
* `cat /etc/os-release` or
* `lsb_release -a` or
* `hostnamectl`

# Create a new user 

* creating a new user `adduser robocop`
* set a password `passwd robocop`
* add the new user to *wheel* group `usermod -aG wheel robocop`

# Change the ssh port

## Check if the ssh is running
- `ps aux | grep sshd`
- check if the process sshd is listening on port 22 `netstat -plant | grep :22`

## Backup current configuration

```bash
date_format=`date +%Y_%m_%d:%H:%M:%S`
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config_$date_format

#check the result
ls /etc/ssh/sshd_config*
```
## Change ssh service port

```bash
sudo vi /etc/ssh/sshd_config
#uncomment the Port line and set your new service port
Port 2121
#save the changes and close the file
```

## Allow new ssh port on SELinux

```bash
semanage port -l | grep ssh
sudo semanage port -a -t ssh_port_t -p tcp 2121
```

## Open ssh port on firewalld
```bash
sudo firewall-cmd --add-port=2121/tcp --permanent
sudo firewall-cmd --reload

#remove ssh service from firewall
sudo firewall-cmd --remove-service=ssh --permanent
sudo firewall-cmd --reload
```
## Restart sshd service
```
sudo systemctl restart sshd
```


# Setting up firewall

## Check the current status
* check the status of the service `sudo systemctl status firewalld`
* checking the status of the firewall daemon `sudo firewall-cmd --state`

## Firewall instalation
* install firewalld `sudo dnf install firewalld -y`
* enable the firewall `sudo systemctl enable firewalld`
* turn the firewall on `sudo systemctl start firewalld`

## Firewall operations
* list allowed services `sudo firewall-cmd --permanent --list-all`
* additional service that you can enable `sudo firewall-cmd --get-services`
* add a new service `sudo firewall-cmd --permanent --add-service=http`
* reload the firewall `sudo firewall-cmd --reload`
  
* Predefined zones from least trusted to most trusted: drop, block, public, external, internal, dmz, work, home, trusted.

* Make rule permanent using the `--permanent` flag.

* Save current rules to the permanent configuration `sudo firewall-cmd --runtime-to-permanent`.

* See wich zone in selected as default `firewall-cmd --get-default-zone`

* See default zone configuration `sudo firewall-cmd --list-all`

* List the available zones `firewall-cmd --get-zones`

* See the configuration asociated with a specific zone `sudo firewall-cmd --zone=home --list-all`

* All the zone definitions `sudo firewall-cmd --list-all-zones | less`

* Changing the zone of an interface `sudo firewall-cmd --zone=home --change-interface=eth0`

* Display the active zones `firewall-cmd --get-active-zones`

* Set the default zone `sudo firewall-cmd --set-default-zone=home`

* Add a service to a zone `sudo firewall-cmd --zone=public --add-service=http`
* Check the service for a zone `sudo firewall-cmd --zone=public --list-services`

* Make the rule permanent `sudo firewall-cmd --zone=public --add-service=http --permanent`

* List permanent services `sudo firewall-cmd --zone=public --list-services --permanent`

* Opening a port `sudo firewall-cmd --zone=public --add-port=5000/tcp`

* Check the ports for a zone `sudo firewall-cmd --zone=public --list-ports`

* Specify a sequential range of ports `sudo firewall-cmd --zone=public --add-port=4990-4999/udp`

## Defining a service 

* copy existing ssh `sudo cp /usr/lib/firewalld/services/ssh.xml /etc/firewalld/services/example.xml`
* adjust the definition `sudo vi /etc/firewalld/services/example.xml`
* example:

```xml
<?xml version="1.0" encoding="utf-8"?>
<service>
  <short>Example Service</short>
  <description>Example service description</description>
  <port protocol="tcp" port="7777"/>
  <port protocol="udp" port="8888"/>
</service>
```

* save and close the file, reload the firewall and check the services

## Creating your own zones

* `sudo firewall-cmd --permanent --new-zone=publicweb`
* `sudo firewall-cmd --permanent --new-zone=privateDNS`
* reload the firewall to bring the zones into the active runtime configuration
* add the services 
  
 ```bash
sudo firewall-cmd --zone=publicweb --add-service=ssh
sudo firewall-cmd --zone=publicweb --add-service=http
sudo firewall-cmd --zone=publicweb --add-service=https
sudo firewall-cmd --zone=publicweb --list-all
 ```

```bash
sudo firewall-cmd --zone=privateDNS --add-service=dns
sudo firewall-cmd --zone=privateDNS --list-all
```

* change out interfaces
```bash
sudo firewall-cmd --zone=publicweb --change-interface=eth0
sudo firewall-cmd --zone=privateDNS --change-interface=eth1
```
* save runtime configuration, reload the firewall and check the zones
* `firewall-cmd --get-active-zones`
* `sudo firewall-cmd --zone=publicweb --list-services`
* `sudo firewall-cmd --zone=privateDNS --list-services`

## Migrate from CentOS-8 to Rocky
* back-up the repos folder `cp -r /etc/yum.repos.d /home/bk_repos`

* update repo list (with vault repos):
```bash
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-Linux-*

sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Linux-*
```

* follow the steps from this [link](https://docs.rockylinux.org/guides/migrate2rocky/)


## Create user with sudo and group
- log in to system as root `sudo su -`
- generate a password `openssl passwd Passw0rd`
- add a new user `useradd -m -c "Klinsmann thor" -s /bin/bash -g software -G software thor -p exZG7uH5BBMSo`
  - `-m` create a home directory for the user `/home/thor`
  - `-c` provides a description of the user, you can provide the user’s full name here.
  - `-s` defines the login shell for the user
  - `-g` defines the group to which the user should be added
  - `-G` adds the user to the preferred group
  - `-p` is an encrypted password that can be generated
- set user account password `passwd thor`
- viewing user account information `getent passwd thor`
- add groups `groupadd software`
- changing the name of a group `groupmod -n group_new_name group_old_name`
- delete a group `groupdel software`
- add user to a group `usermod -g software thor`
- add user to the wheel group 
  ```bash
  vim /etc/sudoers
  ## edit the file by uncommenting the line:
  ## Allows people in group wheel to run all commands
  %wheel ALL=(ALL) ALL
  ## save the file and proceed to add your system user to the group
  ```
- add your system user to the group `usermod -aG wheel username`
- switch to the created user and execute sudo commands `su - thor`
- lock `passwd -l thor` or unlock a user account `passwd -u thor`
- delete a user `userdel -r thor` (delete the user’s home directory and mail spool)