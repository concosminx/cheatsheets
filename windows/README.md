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