# service management

## systemd
- after initialization phase
- replaces SysVinit
- starts OS services
- allows parallel booting
- PID 1
- launches the processes enabled to start on boot
- `systemctl` - command line tool used to control *systemd*

## systemd commands
- `systemctl status <service>` - get status of a service
- `systemctl restart <service>` - restart a service 
- `systemctl stop <service>` - stop a service 
- `systemctl disable <service>` - disable a service 
- `systemctl enable <service>` - enable a service 
- `systemctl start <service>` - start a service 
- `systemctl daemon-reload` - reload config
- `systemctl mask <service>` - mask
- `systemctl unmask <service>` - unmask

## systemd-analyze
- `systemd-analyze time` - default; initialization time
- `systemd-analyze critical-chain` - time critical units as a tree
- `systemd-analyze dump` - all unit types
- `systemd-analyze verify <unit-file>` - scans for configuration
- `systemd-analyze blame` - time for each unit took to initialize
  
## systemd unit files
- `systemctl list-units --type=service`
- 12 types: automount, device, mount, path, scope, service, slice, snapshot, socket, swap, target, timer
- locations:
  - /usr/lib/systemd/system
  - /run/systemd/system
  - /etc/systemd/system (highest precedence)
  

## systemd targets
- control services and system capabilities
  - poweroff.target
  - rescue.target
  - multi-user.target
  - graphical.target
  - reboot.target

- `systemctl get-default` - gets the default target
- `systemctl cat graphical.target` - display the target file
  - check Requires and Wants properties
- `systemctl isolate multi-user.target` - swith to target
- `systemctl set-default <target>` - change default target

## SysVinit
- `service <service-name> <command>` - manages service state
- `chkconfig` - manages service runlevel
