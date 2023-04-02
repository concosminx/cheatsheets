# permissions

## file and directory permissions 
- all files and directory have permission applied
- each object (file or directory) has a permission: read (r), write (w) or execute (x)
- type bit (directory - d, file - none, link - l)
- each object belongs to a user owner (u), group owner (g) and other permission (o)
- octal notation:
  - read: 4
  - write: 2
  - execute: 1
  - number are summed, *rw-rw-r--* is *664*
- permission bits:
  - set user ID (SUID): 4
    - used with executable files (runs the program with the permission of user owner instead of the user running it)
    - shows up as an *s* instead of the execute permission letter `-rws r-x r-x`
    - `find / -perm 4000` find this type of files (octal notation)
  - set group ID (SGID): 2
    - for files - run the permission of group owner instead of the user running it
    - creates a shared directory
    - shows up as an *s* instead of the execute permission letter `-rwx --s --x` or `drwx r-s r-x`
    - `find / -perm 2000`
  - Sitcky bit: 1
    - used to protect files (the files can be deleted by owner or root)
    - shows up as an *t* instead of the execute permission `drwx rwx rwt`
    - `find / -perm 1000`

## permissions utilities
- `chmod` command to modify permissions
  - accept octal or symbolic notation
  - symbolic notation UGO + RWX:
    - `+` to add permissions
    - `-` to remove permissions
    - `=` to set permissions
  - example: `chmod 644 file.txt` or `chmod u=rw,go=r file.txt` (read and write to user, read to group and others)
  - `chmod a=rw file.txt` - `rw` for `ugo`
  - `chmod 4766 file.txt` - have the file executable be able to be run by any user as me 
- `chown` to modify ownership
  - `chown user:group file.txt` - change both
  - `chown user file.txt` - change user
  - `chown :group file.txt` - change group
  - `chown user: file.txt` - change to user and user default group
- `chgrp` command to modify the group
  - `chgrp nginx dir1`

## umask and permissions
- default octal permissions
  - files 666, directories 777
  - controlled by user mask (umask)
- `umask` display 
- 0022 - subtract bits from the default linux permissions
- if u want 775 -> `umask 002`
- from command line affects only current session
- `/etc/profile` - permanent configuration for `umask`

## access control list (ACL)
- overcome basic linux permissions limitations
- objects with an ACL have a period (.) after standard permissions
- examples: `dr-xr-xr-x . ` or `lrwxrwxrwx .` or `-rw-r--r--`
- `getfacl <object>` - view acl
- `setfacl -m u,g,o:<name>:r,w,x<object>` - set acl
  - `setfacl -m u:nginx:rw myFile` - give acces to this file to `nginx`
  - `setfacl -m o:rw myFile` - give access to others
  - `setfacl -b myFile` - reset to default 

## setting limits with ulimit
- `ulimit` - restrict user access to system resources
- options:
  - `-a` see the limits on the current user account
  - `-f` set the limit on the size of files created
  - `-l` maximum memory
  - `-t` maximum CPU time
- to make them permanent we can use user configuration file | global configuration files

## SELinux config
- LSM (Linux Security Module)
- MAC (Mandatory Access Control)
- restricts all actions to least privilege
- implemented via policy rules, controlling access to object types: users, files, directories, network ports, memry, processes
- glosary: 
  - subject (a user or app, requesting access to an object); re
  - reference monitor / monitor: checks the subject's rights
  - context: a label defined for the object, checked by the monitor to verify if a subject has rights to an object
- 3 modes:
  - Disabled 
  - Permissive - performs access checks, logging
  - Enforcing - performs access checks and blocks
  
## SELinux policy
- 3 policy types
  - targeted (default)
  - minimum
  - mls (multi-layer security)
- `sestatus` displays the mode an location of some important files
- `/etc/selinux`

## SELinux tools
- `ls -Z` - displays the file context and the file name
- `ps -Z` - the context for the process running
- `id -Z`, `netstat -Z`
- context label: `user:role:type:level`
- `setenforce` - change the mode of SELinux until reboot
- `chcon` - change the context
  - options: `chcon -u <new user> -r <new role> -t <new type> file_name`
  - `-R` will apply the context change to a directory
- `restorecon` - revert to the default settings
- `sudo semanage boolean -l` 
- `setsebool on`
- `getsebool dhcp_use_ldap`


## AppArmor
- Debian based
- focused on securing applications
- uses profiles
- can run in enforce mode or complain mode
- `/etc/apparmor.d` can contain variabiles name tunables from `/etc/apparmor.d/tunables`
- commands
  - `aa-status`
  - `aa-enforce` - enable a specific profile, or all `aa-enable /etc/apparmor.d/*`
  - `aa-disable` - disable a specific profile
  - `aa-complain` - turn off a specific profile
  - `aa-unconfined` - view active network ports that don't have a profile defined
  
## user types
- Root (ID = 0)
- Service (ID < 1000)
  - used for application that run and start in the background
- Standard (ID > 1000)
- determine user type from `/etc/passwd`

## privilege escalation 
- best practice is to use a standard user account and use privilege escalation to run programs with root privileges
- `su`
  - allows a standard user to run commands as another user
- `sudo`
  - doesn't require root password; must pe in a priviledged group
- `sudoedit`
  - similar to sudo in order to edit a file
- privilege groups
  - `wheel` - RH based distros
  - `sudo` - Debian based distros
  - these groups need to be enabled in the sudoers file: `/etc/sudo` (with `visudo`)
  