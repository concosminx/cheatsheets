# software management

## package types 
1) RPM (CentOS, Fedora, Scientific Linux)
  - installed with `rpm` command
2) deb (Ubuntu)
  - installed with `dpkg`
  
### the tape archiver (tar), gz and tgz
- used to bundle files together into a *tar* file 
- gzip program allows to compress (zip) files
- tgz = tar + gzip
- used to distribute *un-compiled* software

## RPM command
- used with RPM package manager
- `rpm -i httpd.xyz.x86_64.rpm` - does not install dependencies ...
- `rpm -ivh pidgin.xyz.x86_64.rpm` - install, verbose, hashmarks (progress)
- `rpm -qld pidgin` - query, list (all the files installed), documentation
- `rpm -qa` - all the packages installed
- `rpm -e` - uninstall (extract)

## RPM package managers
1) `yum`
  - Yellowdog Updater Modified - current package manager in RHEL
  - `yum install httpd` - install httpd and dependencies
  - `yum info httpd` - information about the packages installed
  - `yum list installed` - displays all packages
  - `yum remove httpd` - remove package and unused dependencies
  - `yum search pidgin` - search package
  - `yum repolist` - displays repositories
  - `yum clean all` - cleanup
  - `yum check-update` - check for updates
  - `yum update` - update packages 
  
2) `dnf`
  - Dandified Yum - used in community editions: CentOS, Fedora; replacement for yum
  - options similar with yum 
  - `dnf install mariadb -y`
  
3) `zypper`
  - used in Suse
  
## DPKG tools
  
### package managers for dpkg
  
1) `dpkg`
  - command-line tool for Debian-based distro
  - `dpkg -i apache2.xyz.deb` - does not install dependencies
  - `dpkg -I <package>` - get info about the packages installed
  - `dpkg -L <package>` - see all the installed files
  - `dpkg -r <package>` - remove the package

2) `apt-get` 
  - package manager for Debian-based distros
  - `apt-get update` - update the package list from repositories
  - `apt install apache2` - installs apache2
  - `apt purge apache2` - cleanup package
  - `apt-cache show apache2` - see information about package
  - `apt-cache pkgnames` - show all the packages
  - `apt remove apache2` - uninstall a package
  - `apt search pidgin` - search a package
  - `apt upgrade` - update all the packages
  - `apt clean` - cleanup the system
  
3) `aptitude` 
  - text based graphical package manager that works like *apt-get*
  - `aptitude` - will provide a text GUI
  
## build tools
- install software from source code (not available or you want to customize the installation)
- `tar -xzvf <file_name>.tgz` - extract a gziped tar file
- `tar -xvf <file_name>.tar` - extract a regular tar file
- find the configure script (`./configure`); does some verifications and creates a Mekefile
- use `make` command to call the compiler; will generate a compiled executable
- use `make install` tok install the compiled package

## working with libraries
- shared libraries
- dynamic shared libraries (.so - shared object)
- `ldd` - used to find the libraries required for a program to run
- `ldd /user/bin/diff` - all the libraries that diff needs to run
- stored in (/lib, /usr/lib, /lib64, /usr/lib64)
- paths to library files stored id (/etc/ld.so.conf, /etc/ld.so.conf.d, LD_LIBRARY_PATH)
- `ldconfig` - used to build `ld.so.cache`


## repositories
- servers that holds the collection of software
- /etc/yum/repos.d (CentOS)
- /etc/apt/sources/list (Ubuntu)


## repository commands
- `cd /etc/yum.repos.d`
- create a new repo (see example files)
- `yum reposync`

## acquisition commands
- `wget`
  - `wget <URL of file or package to download>`
- `curl`
  - `curl -O <URL of file or package to download>`
  - use `-o <file name>` to specify the file name





  
