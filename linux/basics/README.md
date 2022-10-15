# Table of contents

- [Table of contents](#table-of-contents)
- [Help](#help)
- [Basic commands](#basic-commands)
- [Environmental variables](#environmental-variables)
- [System information](#system-information)
- [Performance monitoring and statistics](#performance-monitoring-and-statistics)
- [Processes](#processes)
- [Network](#network)
- [SSH](#ssh)
- [Install software](#install-software)
- [Install software from source code](#install-software-from-source-code)
- [Searching](#searching)
- [File & folders permissions](#file--folders-permissions)
  - [Permissions examples](#permissions-examples)
- [Compression](#compression)
  - [Tar flags examples](#tar-flags-examples)
- [User information and management](#user-information-and-management)
  - [Switching users](#switching-users)
- [Shortcuts](#shortcuts)
- [File transfers](#file-transfers)
- [Scheduling](#scheduling)
  - [Scheduling examples](#scheduling-examples)
  - [Execute programs in the background](#execute-programs-in-the-background)
  - [Flow redirection](#flow-redirection)
  - [Flow redirection examples](#flow-redirection-examples)
  - [Chain commands](#chain-commands)
- [Wildcards](#wildcards)
- [Comparing the contents of files](#comparing-the-contents-of-files)
- [Aliases](#aliases)
- [Shell History](#shell-history)

---

# Help

* `man <command>` - shows manual
* Commands (in `man`): 
  * `enter` - moves down one line 
  * `space` - moves down one page
  * `g` - top of the page
  * `G` - bottom of the page
  * `q` - quit


# Basic commands

* `ls` - list directory content
  * `-l` - long listing format
  * `-a` - hidden files
  * `-r` - reverse order
  * `ls <folderName>` - list files in folder
  * `ls -lh` - detailed list, human readable
  * `ls -l *.jpg` - list jpg files only
  * `ls -lh <fileName>` - result for file only 
* `tree` - displays directory tree
* `cd` - change directory
  * `cd` -  change to home
  * `cd /` - change to root
  * `cd <folderName>` - change directory to *path*; use `" "` if  folder name has spaces 
  * `cd ..` - go up one folder, tip: ../../../ 
  * `cd-` - change to the previous directory
  * `.` - this directory
* `pwd` - print working directory
* `mkdir <folderName>` - create directory 
  * `mkdir myStuff ..`
  * `mkdir myStuff/pictures/ ..`
  * `-p` - parrents
* `rmdir` - remove a directory (works only if the directory is empty)
* `rm` - remove file / directory 
  * `rm <fileName> ..` - delete file (s) 
  * `rm -r <foldername>/` - delete folder
  * `rm -f <fileName>` - force deletion of a file 
  * `rm -i <fileName> ..` - ask for confirmation each file 
* `cp` - copy
  * `cp file1 file2` - copy file1 to file2
  * `cp -r source_directory destination` - copy  source_directory recursively to destination. If destination exists, copy source_directory into destination, otherwise create destination with the contents of source_directory
  * `cp image.jpg newimage.jpg` - copy and rename a file
  * `cp image.jpg <folderName>/` - copy to folder
  * `cp image.jpg folder/sameImageNewName.jpg`
  * `cp -R stuff otherStuff` - copy and rename a folder
  * `cp *.txt stuff/` - copy all of \*\<file type\> to folder
* `mv <file1> <file2>` - rename file1 to file2
  * `mv file.txt Documents/` - move file to a folder
  * `mv <folderName> <folderName2>` - move folder in folder
  * `mv filename.txt filename2.txt` - rename file
  * `mv <fileName> stuff/newfileName`
  * `mv <folderName>/ ..` - move folder up in hierarchy
* `touch <fileName>` - create or update a file
  * `touch afile-{a..c}.txt` - creates a afile-a.txt, afile-b.txt, afile-c.txt
  * 
* `cat <fileName>` - concatenates and displays files; u can use-it to concatenate files `cat file1.txt file2.txt > bigfile.txt`
* `more <fileName>` - output the contents of the file/paging
* `less <fileName>` - output the contents of the file/paging
* `head <fileName>` - output first 10 lines of file; from the top `-n <#oflines> <fileName>` 
* `tail <fileName>` - output last 10 lines of file; from the bottom `-n <#oflines> <fileName>`
* `tail -f file` - output contents of file as it grows
* `ln` - create link
  * `ln -s /path/to/file linkname` - create symbolic link to linkname
  * `ln file1 file2` - physical link
  * `ln -s file link` - create symbolic link 'link' to file
* `echo` - displays arguments to the screen
* `clear` - clears the screen

# Environmental variables

* `echo $VAR_NAME`
* `PATH` - contains list of directories (separated with “:”)
*	`printenv` - (display all variables)
* `printenv HOME` - (display HOME variable)
* `echo $HOME`
*	`export VAR-”value”` - (create VAR variable)
* `unset VAR` - (remove env. variable)


# System information

* `date` - show current date/time 
* `cal` - show this month's calendar
* `uptime` - sow uptime 
* `w` - who is logged on and what they are doing 
* `whoami` - who are you login as 
* `uname -a` - show kernel config 
* `cat /proc/cpuinfo` - cpu info 
* `cat /proc/meminfo` - memory info
* `df` - show disk usage 
* `du` - show directory space usage 
  * `du -sh` - human readable size in GB 
  * `du -h` - disk usage of folders, human readable 
  * `du -ah` - disk usage of files & folders, human readable 
  * `du -sh` - only show disk usage of folders
* `free -h` - display free and used memory ( -h for human readable, -m for MB, -g for GB.)
* `whereis app` - show posible locations of app 
* `which app` - show which app will be run by default 
* `cat /etc/redhat-release` - show which version of redhat installed
* `hostname` - show system host name
  * `hostname -I` - display the IP addresses of the host
* `dmesg` - display messages in kernel ring buffer
* `lspci -tv` - display PCI devices
* `lsusb -tv` - display USB devices
* `dmidecode` - DMI/SMBIOS (hardware info) from the BIOS
* `hdparm -i /dev/sda` - info about disk sda
  * `hdparm -tT /dev/sda` - perform a read speed test on disk sda
* `badblocks -s /dev/sda` - test for unreadable blocks on disk sda
* `fdisk -l` - display disks partitions sizes and types


# Performance monitoring and statistics

* `top` - display and manage the top processes; `q`  to close top; `h` to show the help; `k`  to  kill a process
* `htop` - interactive process viewer (top alternative)
* `mpstat 1` - display processor related statistics
* `vmstat 1` - display virtual memory statistics
* `iostat 1` - display I/O statistics
* `tail 100 /var/log/messages` - display the last 100 syslog messages  (Use /var/log/syslog for Debian based systems.)
* `tcpdump` - packet sniffing
  * `tcpdump -i eth0` - capture and display all packets on interface eth0
  * `tcpdump -i eth0 'port 80'` - monitor all traffic on port 80 ( HTTP )
  * `-n` - display numerical addresses and ports
  * `-v` or `-vvv` - verbose ...
* `lsof` - list all open files on the system
* `lsof -u user` - list files opened by user
* `watch df -h` - execute `df -h`, showing periodic updates
* `tload`  -  graphic  representation  of  system   load  average (quit with CTRL C)

	
# Processes
* `ps` - display your currently running processes
  * `ps -ef` - display all the currently running processes on the system.
  * `ps aux` - ps with a lot of details 
  * `ps -ef | grep processname` - display process information for processname
* `-u` - process's from current user
* `kill pid` - kill process with process ID of pid; You need the PID # of the process `ps -u <AccountName> | grep <Application>`; view signal names with `kill -l`
* `CTRL+C` - kills the foreground process
  * `kill -9  <PID>` - horror kill :)  
* `kilall proc` - kill all processes named *proc*
* `bg [%num]` - background a suspended process 
* `fg [%num]` - foreground a background process 
* `jobs [%num]` - list jobs 
* `program &` - start program in the background

* reboot
  * `telinit 6`
  * `systemctl isolate reboot.target`
  * `shutdown [options] time [message]`
  * `shutdown -r 15:30 "rebooting!"`
  * `shutdown -r +5 "rebooting soon!"`
  * `shutdown -r now`
  * `reboot`

* poweroff
  * `telinit 0`
  * `systemctl isolate poweroff.target`
  * `poweroff`
  

# Network

* `ping host` - ping host *host*
  * `ping -c 3 google.com` 
* `whois domain` - get whois for domain
* `dig domain` - get DNS for domain 
  * `dig -x host` - reverse lookup host 
* `wget file` - download file 
  * `-c file` - continue stopped download 
  * `-r url` - recursively download files from url 
* `traceroute -n google.com`
* `ifconfig -a` - display all network interfaces and ip address
  * `ifconfig eth0` - display eth0 address and details
* `ethtool eth0` - query or control network driver and hardware settings
* `host domain` - display DNS ip address for domain
* `hostname -i` - display the network address of the host name
* `hostname -I` - display all local ip addresses
* `netstat -nutlp` - display listening tcp and udp ports and corresponding programs
  * `netstat -rn` - displays the route table
  * `netstat -nlp` - display listening sockets
  * `netstat -ntlp` - limit the output to TCP
* `telnet HOST_OR_IP PORT_NUMBER`
* `ip address` - determining your IP address
* `hostnames` - human-readable name for an IP address

* setting the hostname
  * `hostname webprod01`
  * `echo 'webprod01' > /etc/hostname`

* `/etc/hosts` - local hosts file
  * `IP FQDN alias(es)` - the file format (127.0.0.1 locahost)

* `/etc/services` - maps port names to port numbers

# SSH
* `ssh user@host` - connect to host as user
* `ssh -p port user@host` - connect using port


# Install software
* `yum` - CentOS (pkg. manager)
  * `yum search keyword` - search for a package by keyword
  * `yum install [-y] package` - install package
  * `yum info package` - display description and summary information about package
  * `yum remove package` - remove/uninstall package.

* `sudo apt-get install <nameOfSoftware>` 
  * `sudo apt-get install aptitude` - example instalation

* `rpm -qa` - list all installed packages
* `rpm -qf /path/to/file` - list the file’s package
* `rpm -ql package` - list package’s files
* `rpm -ivh package.rpm` - install a package
* `rpm -e package` - erase a package

# Install software from source code

* `tar zxvf sourcecode.tar.gz`
* `cd sourcecode`
* `./configure`
* `make`
* `make install`


# Searching

* `grep` - print lines matching a pattern
  * `grep pattern files` - search for pattern in files 
  * `grep -r <text> <folderName>/` - search for file names with occurrence of the text
  * `command | grep pattern` - search for pattern in the output of command 
  * `grep <someText> <fileName>` - search for text in file
  * `-i` - doesn't consider uppercase words
  * `-I` - exclude binary files
  * `grep -E ^<text> <fileName>` - search start of lines with the word text
  * `grep  -E <0-4>  <fileName>` -shows  lines  containing  numbers  0-4
  * `grep -E <a-zA-Z> <fileName>` - retrieve all lines with alphabetical letters
* `locate` - find files by name 
  * `locate <fileName>` - search for a file
  * `sudo updatedb` - update database of files
* `find` - search for files in a directory hierarchy
  * `find -name "text*"` - search for files who start with the word text
  * `find -name "*text"` - search for files who end with the word text
  * `find ~ -size +10M`  -  search files bigger  than.. (M,K,G)
  * `find  -name  “<filetype>” -atime -5` - search from last access ('-' - less than, '+' - more than and nothing - exactly)
  * `find  -type  d` - search only directories 
  * `find  -type  f` - search only files 
* `sort` - sort the content of files
  * `sort <fileName>` - sort alphabetically
  * `sort -o <file> <outputFile>` - write result  to  a  file 
  * `sort -r <fileName>` - sort in reverse
  * `sort -R <fileName>` - sort randomly
  * `sort -n <fileName>` - sort numbers
* `uniq` - report or omit repeated linesq
* `wc` - word count
  * `wc <fileName>` - nbr of line, nbr of words, byte size `-l` (lines); `-w` (words); `-c` (byte size); `-m` (number of characters)
* `cut` - cut a part of a file
  * `cut -c 2-5 names.txt` - (cut the characters 2 to 5 of each line)


# File & folders permissions
* `chmod octal file` - change permissions of file 
  * `4` - read(r)
  * `2` - write(w)
  * `1` - execute(x)
  * `order` - owner/group/world

* `chmod g+w someFile.txt` - (add to current group the right to modify someFile.txt)
  * `+` add a right
  * `-` delete a right
  * `-` affect a right


## Permissions examples

| User | Group | Everyone | **Example**      |
|------|-------|----------|-------------     |
| rwx  | rwx   | rwx      |chmod 777 filename|
| rwx  | rwx   | r-x      |chmod 775 filename|
| rwx  | r-x   | r-x      |chmod 755 filename|
| rw-  | rw-   | r--      |chmod 664 filename|
| rw-  | r--   | r--      |chmod 644 filename|


* Legend: `r` - read; `w` - write; `x` - execute; `-` - no access;

* `chown` - change the owner of a file 
  * `-R` - recursively affect all the sub folders ex 
  * `chown -R john:john /home/MyFolder`


# Compression

* `tar` - compress / extract files
* `tar cf archive.tar directory` - create tar named archive.tar containing directory
* `tar xf file.tar` - extract in current directory
* `tar tf file.tar` - show content of archive
* `tar czf file.tar.gz files` - creates a tar uzing Gzip compression 
* `tar xzf file.tar.gz` - extract a tar using Gzip 
* `tar cjf file.tar.bz2 files` - creates a tar uzing Bzip2 compression 
* `tar xjf file.tar.bz2` - extract a tar using Bzip2 

## Tar flags examples
* `c` - create archive 
* `t` - table of contents 
* `x` - extract 
* `f` - specifies filename 
* `z` - use zip / gzip 
* `j` - bzip2 compression 
* `k` - do not overwrite 
* `T` - files from file 
* `w` - ask for confirmation 
* `v` - verbose

* `gzip file` - compresses file and renames it to file.gz (keep the original file with `-k`)
* `gzip -d file.gz` - decompresses file.gz back to file 
* `gzcat` - concatenates compressed files
* `zcat` - concatenates compressed files


# User information and management
* `id` - display the user and group ids of your current user.
* `last` - display the last users who have logged onto the system.
* `who` - show who is logged into the system.
* `w` - show who is logged in and what they are doing.
* `groupadd test` - create a group named "test"
* `useradd -c "John Doe" -m john` - create an account named john, with a comment of "John Doe" and create the user's home directory.
* `userdel john` - delete the john account.
* `usermod -aG sales john` - add the john account to the sales group

* `sudo adduser bob` - root creates new user
* `sudo passwd <AccountName>` - change a user's password
* `sudo deluser <AccountName>` - delete an account

* `addgroup friends` - create a new user group
* `delgroup friends` - delete a user group

* `usermod -g friends <Account>` - add user to a group
* `usermod -g bob boby` - change account name
* `usermod -aG friends bob` - add groups to a user without loosing the ones he's already in

## Switching users

* `su [username]` - change user ID or become superuser
	* `-` - a hyphen is used to provide an environment similar to what the user would expect had the user logged in directly
  * `-c command` - specify a command to be executed

* `sudo` - execute a command as another user, typically the superuser
* `sudo -l` - list available commands
* `sudo command`
* `sudo -u root command` - same as above
* `sudo -u user command` - run as user
* `sudo su` - switch to the superuser
* `sudo su -u` - switch to the superuser account with root’s environment
* `sudo su - username` - switch to the username account
* `sudo -s` - start a shell
* `sudo -u root -s` - same as sudo -s
* `sudo -u user -s` - start a shell as root

* Changing the configuration `visudo` (edit the /etc/sudoers file)

# Shortcuts

* `CTRL + C` - halts current command 
* `CTRL + Z` - stops current command 
* `CTRL + D` - logout from current session 
* `CTRL + W` - erases one word in current line 
* `CTRL + U` - erases the whole line 
* `CTRL + R` - reverse lookup of previous cmds
* `CTRL + L` - Clear the terminal
* `SHIFT + Page Up/Down` - Go up/down the terminal
* `CTRL + A` - Cursor to start of line
* `CTRL + E` - Cursor the end of line
* `CTRL + K` - Delete right of the cursor
* `CTRL + W` - Delete word on the left
* `CTRL + Y` - Paste (after CTRL U,K or W)
* `TAB` - auto completion of file or command
* `CTRL + R` - reverse search history
* `CTRL + Z` - stops the current command (resume with fg in foreground or bg in background)

* `!!` - repeat last command 
* `exit` - log out of current session



# File transfers

* `scp file.txt server:/tmp` - secure copy file.txt to the /tmp folder on server
* `scp server:/var/www/star.html /tmp` - copy \*.html files from server to the local /tmp folder
* `scp -r server:/var/www /tmp` - copy all files and directories recursively from server to the current system's /tmp folder.
* `rsync -a /home /backups/` - synchronize /home to /backups/home
* `rsync -avz /home server:/backups/` - synchronize files/directories between the local and remote system with compression enabled

# Scheduling


1. Write in the terminal: `at  <timeOfExecution>` ENTER
(ex --> `at 16:45` or `at 13:43 7/23/11`)
or  after  a certain delay:
`at now +5 minutes` (hours, days, weeks, months, years)
2. `<ENTER COMMAND>` ENTER
repeat step 2 as many times you need
3. `CTRL + D`  to close input


* `atq` - show a list of jobs waiting to be executed
* `atrm` - delete a job n°<x> (delete  job  #42  --> atrm 42)

* `sleep` - pause between commands

* `;`  chain commands, ex: `touch file; rm file`
you  can  make  a  pause  between  commands  (minutes,  hours,  days); ex --> `touch file; sleep 10; rm file` 

* `cron` - a time based job scheduling service
* `crontab` - a program to create, read, update, and delete your job schedules


* Crontab format 
  * `* * * * *`
  * (1) – minute (0-59)
  * (2) – hour (0-23)
  * (3) – day of the month (1-31)
  * (4) – month of the year (1-12)
  * (5) – day of the week (0-6)

* Shortcuts:
  * `@yearly 0 0 1 1 *`
  * `@annualy 0 0 1 1 *`
  * `@monthly 0 0 1 * *` 
  * `@weekly 0 0 * * 0`
  * `@daily 0 0 * * * `
  * `@midnight 0 0 * * *`
  * `@hourly 0 * * * *`


* `crontab file` - install a new crontab from file
* `crontab -l` - list your cron jobs
* `crontab -e` - edit your cron jobs
* `crontab -r` - remove all of your cron jobs


## Scheduling examples

* Create the file movies.txt every day at 15:47:` 47 15 * * * touch /home/bob/movies.txt`
* `*  *  *  *  *`  -  every  minute
* at  5:30  in  the  morning,  from  the  1st  to  15th  each  month: `30 5 1-15 * *`
* at midnight on Mondays, Wednesdays and Thursdays: `0 0 * * 1,3,4`
* every two hours: `0 */2 * * *`
* every 10 minutes Monday to Friday: `*/10 * * * 1-5`
* `0 7 * * 1 /opt/sales/bin/weekly-report` - run every Monday at 07:00
* `0 2 * * * /root/backupdb > /tmp/db.log 2>&1` - run at 02:00 every day and #send output to a log file
* `0.30 * * * * /…` or `*/2 * * * * /…` - run every 30 minutes
* `0-4 * * * * /…` - run for the first 5 minutes of the hour 


## Execute programs in the background

* Add a '&' at the end of a command: `cp bigMovieFile.mp4 &`
* `nohup`:  ignores  the  HUP  signal  when  closing  the  console; (process will still run if the  terminal  is  closed): `nohup cp bigMovieFile.mp4`

* `jobs` - know what is running in the background

## Flow redirection

* I/O Redirection
  -	stdin (0)
  -	stdout (1)
  -	stderr (2)

* `>` - redirects standard output to a file; overwrites (truncating) existing contents;
* `>>` - redirects standard output to a file; appends to any existing contents
* `<` - redirects input from a file to a command
* `&` - used with redirection to signal that a file descriptor is being used
* `2>&1` - combine stderr and standard output
* `2>file` - redirect standard error to a file
* `>/dev/null` - redirect output to nowhere

## Flow redirection examples
* `ls files.txt not-here.txt >/dev/null 2>&1` - redirects std output to null and standard error to std output

* Read progressively from the keyboard: `<Command> << <wordToTerminateInput>`

  * `sort  <<  END` 
  * `>	Hello`
  * `>	Alex`
  * `>	Cinema`
  * `>	Game`
  * `>	END`

* terminal output:
  * Alex
  * Cinema
  * Code
  * Game

## Chain commands

* `|` at the end of a command to enter another one: `du | sort -nr | less`
* `xargs` - build and execute command lines from standard input

# Wildcards
* used for pattern matching
  *	`*` - zero or more characters
  * `?` - exactly one character
  *	`[ ]` - a character class; any of the characters included between the brackets; matches exactly one character
* `[!]`– matches any of the characters NOT included between the brackets; matches exactly one character
*	named character classes
  - `[[:alpha:]]`
  - `[[:alnum:]]`
  - `[[:digit:]]` 
  - `[[:lower:]]`
  - `[[:space:]]`
  - `[[:upper:]]`

*	`\` - escape character; use if you want to match a wildcard character


Examples 
* `[aeiou]` – 1 character, vowel
* `ca[nt]*` - starts with ca, followed by one of n | t, and 0 ore more characters
* `[!aeiou]*` - first character not a|e|i|o|u
* `[a-g]*` - all files that start with a,b,c,d …, g
* `[3-6]*` - all files that start with 3,4,5 or 6
* `ls *.txt`
*	`ls a*.txt`
*	`ls ?`
*	`ls a?.txt`
*	`ls c[aeiou]t`
*	`ls [a-d]*`
*	`ls *[[:digit:]]`
*	`mv *mp3 music/`
*	`rm ??`



# Comparing the contents of files

* `diff file1 file2` – compare 2 files
* `sdiff file1 file2` – side by side comparision
* `vimdiff file1 file2` – highlight differences in vim 


# Aliases
*	shortcut 
*	use for long commands
* `alias [name[-value]]`
* `unalias name` (remove the “name” alias)
* `unalias -a` (remove all aliases)
* Add aliases to you personal initialization files `.bash_profile` / `.bashrc` (reload with `source`)



Examples: 
* `alias grpe-’grep’` (to fix typos)
* `alias cls-’clear’` (behave like another OS)


# Shell History
* In memory or
* ~/.bash_history
* ~/.history
* ~/.histfile

* `history` (displays the shell history)
* `HISTSIZE` (evn. var for number of commands to retain ~ 500)

* `!Syntax`
  * `!N` (repeat command line number N)
  * `!!` (repeat the previosu command line)
  * `!string` (repeat the most recent command starting with “string”)
* `!:N <Event> <Separator> <Word>` - where `:N` - a word on cmd line, `0` - command, `1` - first argument, etc.
* `!^` (first arg) and `!$` (last arg)

Examples:

* `head files.txt sorted_files.txt`
* `!!` - (repeat all cmd)`
* `vi !:2` - (the same as vi sorted_files.txt)
