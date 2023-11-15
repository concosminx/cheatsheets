# Commands

## Copy folders and subfolders
* and content `Xcopy C:\Production X:\BackUp /E /H /C /I`
* without content (files) `Xcopy C:\Production X:\BackUp /T /E`

## Search a String in another command output
```shell
ipconfig /all | findstr IP
```

## Refresh IP from DHCP 
```shell
ipconfig /realese
ipconfig /renew
```

## Display DNS records and copy the output in Clipboard
```shell
ipconfig /displaydns | clip
```

## Delete DNS Resolver Cache
```shell
ipconfig /flushdns
```

## Use nslookup
```shell
nslookup asus.com
```

## Display mac addresses
```shell
getmac /v
```

## Display power cfg info
- energy or power issues `powercfg /energy`
-  battery info `powercfg /batteryreport`

## View and modify file associations
- view `assoc`
- assoc .mp4=VLC.vlc

## Check disk | system files | etc
- `chkdsk` - check the options for this cmd
- `sfc /scannnow ` - file system scan
- `DISM /Online /Cleanup /CheckHealth`
- `DISM /Online /Cleanup /ScanHealth`
- `DISM /Online /Cleanup /RestoreHealth`

## List the current running tasks and kill a task
- `tasklist` - get the list
- `taskkill /f /pid 21211` - kill the process with the PID = 21211

## How to use netsh
- wireless report: `netsh wlan show wlanreport`
- show the interfaces: `netsh interface show interface`
- ip addresses: `netsh interface ip show address | findstr "IP Address"`
- view dns servers: `netsh interface ip show dnsservers`
- turn off firewall: `netsh advfirewall set allprofiles state off`
- turn on firefall: `netsh advfirewall set allprofiles state on`

## Ping a server
- `ping -t google.com` 

## Trace path to server
- `tracert google.com` 
- `tracert -d google.com` - use `-d` to not resolve the domain names

## How to use netstat
- `netstat`
- see open ports `netstat -af`
- see the process ids `netstat -o`
- see statistics `netstat -e -t 5`

## See route table
- view `route print`
- add a route `route add [ip] mask [mask] gateway`
- delete a `route delete [ip`

## Restart in system Bios 
`shutdown /r /fw /f /t 0`

## Open command prompt in administrator mode
`runas /user:Administrator cmd`

## Hide a zip | rar file
`copy /b image.extension+folder.zip image.extension`

## Encrypt files in a folder
`cipher /E`

## Hide a folder
`attrib +h +s +r foldername` and unhide it with `attrib -h -s -r foldername`

## Show wi-fi passwords
- show the list of WiFi networks: `netsh wlan show profile`
- show the password: `netsh wlan show profile wifinetwork key=clear | findstr “Key Content”`
- see all WiFi networks: `for /f "skip=9 tokens=1,2 delims=:" %i in ('netsh wlan show profiles') do @if "%j" NEQ "" (echo SSID: %j & netsh wlan show profiles %j key=clear | findstr "Key Content") & echo.`

## Detailed system operating and configuration info
`systeminfo`

## Copy files between remote hosts
`scp file.txt root@serverip:~/file.txt`

## Map a regular folder as a mounted drive
`subst t: c://filelocation` and `subst /d t:` to remove it

## Change the Background and Text color in cmd
`color 07 [background:text]`

## curl examples
- `curl wttr.in/location` - weather
- `curl --head --location “<https://short/exp> | location` - destination for shortened link
- `curl checkip.amazonaws.com` - check the ip
- `curl qrenco.de/https://www.emag.ro` - generate qr

## Visit a site 
`start emag.ro`

## Delete temporary files
`del /q /f /s %temp%\\*`

## History 
`doskey / history`

## Create a new file
`type nul> file-name.extension`

## View the task list
`tasklist`

## Kill a task
`taskkill /PID 1234`

## View running services
`net start`

## Stop a service 
`net stop "Windows Time"`

## See the drivers
`driverquery`

## Collect system info
- `wmic`
- `/output:c:\info.txt product get name,version`
- `cpu`

## Details about the disk(s)
- `diskpart`
- `list disk`
- `detail disk`
- `select disk 1` - select a disk
- `clean` - check the disk
- `create partition primary` - create a primary partition
- `select partition 1` - create first partition
- `format fs=ntfs quick` - format a NTFS quick
- `active` - activate the drive
- `assign` - assing the partition
- `exit` - exit the `diskpart` tool
- `label f:` - assing a label


## Check disk(s)
`chkdsk`

## See MAC address
`getmac`

## System information
`systeminfo`

## User management
- `lusrmgr.msc`
- `net user` - see users
- `net user a-new-user /add passw0rd` - create a new user with password
- `net user /del a-new-user` - delete a user
- `net user administrator /active:yes` - enable administrator account
- `net user "my-user" *` - disable password

## Hyde and encrypt files
- `attrib +H +R +S` - hide the files
- `attrib -H -R -S` - show the files
- `cipher /e` - encrypt
- `cipher /d` - decrypt
- `cipher /rekey` - upgrade keys

## File associations
- `assoc.txt` - check `.txt` file association

## Creating and exporting files
- `echo blabla > my-file.txt` 
- `copy con my-console-file.txt` - multi line txt (stop with Ctrl + Z)
- `type filename.txt` - display the text file in the command

## Other commands
- `tree` - display directory tree
- `date` - change date
- `time` - similar with date
- `doskey/history` - see command history
- `shutdown`
    - `-s` - shutdown
    - `-t` - specify a time (seconds)
    - `-r` - restart
- `chkntfs DRIVE_LETTER:` - checks the ntfs file system
- `schtasks` - view all scheduled tasks
- `ver` - MS win version
- `openfiles` - files opened remotely


## The `ipconfig` command
- `ipconfig` - general info
- `ipconfig /all` - more info
- `ipconfig /renew` - refresh the IP
- `ipconfig /displaydns` - all DNSs
- `ipconfig /flushdns` - flush the DNS cache


## The `ping` tool 
- `ping IP`
- `ping -t IP` -  ping the specified host until stopped
- `ping -a IP` - resolve addresses to hostnames


## The `tracert` tool
- `tracert google.com` - tracing route to google.com

## The `netstat` tool
- `netstat` - current network connections
- `netstat -b` - see applications

## Other tools
- `arp` - Displays and modifies the IP-to-Physical address translation tables used by
address resolution protocol
- `nslookup`



