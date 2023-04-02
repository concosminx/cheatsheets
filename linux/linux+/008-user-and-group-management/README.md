# user and group management

## user and group creation 

### *useradd* command
- `/etc/default/useradd` - user variable settings
- `/etc/login.defs` - group and home directory creation
- `/etc/skel` - default home directory file
- `useradd -G wheel user-test-1` - add a user in a specific group (CentOS)
- `useradd user-test-1` - add a user in Ubuntu; by default will not create the home directory; use `-mG sudo` to add the user in the `sudo` group and create the home dir
- `grep user-name /etc/passwd` - check
 

### *groupadd* command
- `groupadd -g 1337 best-group`
- `grep best-group /etc/group` - check


## user and group modification

### *usermod* command
- modify existing user
- `usermod -aG` - append an additional group
- `usermod -L` - lock a user account
- `id test2` - check the user `test2`
- `passwd test2` - asign a password to `test2`
- `grep test2 /etc/shaddow` - check the password (if starts with `!` the user is lock)
- `usermod -U test2` - unlock a user

### *groupmod* command
- `groupmod -n` - change the name
- `groupmod -g` - change the group id

## user and group deletion 

### *userdel* command
- `userdel` - deletes the user account
- `userdel -r` - deletes the user account and home dir

### *groupdel* command
- `groupdel` - deletes a group 

## file locations
- `/etc/passwd` - a record for each user; 
    - username | has a password | user id | group id | cid | home dir | default shell
- `/etc/shadow` - stores passwords / each line = record; 
    - username | password (hashed) | days since 01.01.1970 | min days before passwd change allowd | max days valid | warning days | days disabled | days expired
- `/etc/group` - 4 fields / line
    - group name | x | group id | list of added users

## password management

- `passwd` - used by any user to change own password
- options `-l`, `-u`, `-e`: lock, unlock, expire
- `-d` - deletes user password
- `chage` - modify password aging settings
- options `-W`, `-E`, `-m`, `-M`: warning days, expiration date, wait days, password change

## query commands
- `id <user name>` - displays account information on any user
- `whoami` - displays effective user
- `who` - all currently logged users
- `w` - similar with `who` and adds load info
- `last` - info about the last account

## enabling quotas
- `lsblk` - see initial info
- `vim /etc/fstab` - and add `usrquota, grpquota` after `defaults`
- `mount -o remount,rw /mnt/ext4`
- `mount | grep usrquota`
- `quotacheck -avugc` - check the man page

## user and group quotas
- `edquota -u <user name>` - create for a user
- `edquota -g <group name>` - create for a group
- blocks or inodes; soft (with a grace period) and hard limit
- `edquota -t` - set grace
- `quota -u <user name>` - show quota for a user
- `quota -g <group name>` - show quota for a group
- `repquota <mount point>` - report quota for a mount point
- `repquota -a` - show all

## bash profiles
- used to persist options, variables and aliases
- `/etc/profile` - global configuration; first sourced
- `/etc/profile.d` - directory with global configuration
- `~/.bash_profile` - user bash profile (from home)
- `~/.bashrc` - user specific environments (rc - run command)
- `~/.bash_logout` - logout stuff
- `~/.profile` - similar to `~/.bash_profile`; it's used in *ubuntu*
- bashrc - hte only one sourced when `su -` (non login process)

## global entries
- `/etc/bashrc` - sourced by every user `~/.bashrc`
- `/etc/skel` - default files placed in the home directory [.bashrc, .bash_logout, .bash_profile (CentOS), .profile (Ubuntu)]