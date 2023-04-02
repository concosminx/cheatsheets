# logging

## key log file locations
- majority of logs in `/var/log` 
  - `/secure` - security logs, connection attempts
  - `/messages` - general purpose log messages
  - `/kern.log` - ... only on some distros
  - `/[application] - specific to application (/var/log/httpd)
- `sudo grep --color -i "warning" /var/log/messages`
- `sudo tail -f /var/log/secure`

## log management
- `syslog` - standard message format
  - timestamp, type (23), severity (8), details
- `sudoedit /etc/rsyslog.conf`
  - includes `/etc/rsyslog.d/*.conf`

## log rotation 
- `logrotate` - is run daily by default
- `/etc/logrotate.conf`
- `/etc/logrotate.d/` - dir
- see manual *https://linuxconfig.org/logrotate-8-manual-page*

## journald
- logs to a binary file
- `/etc/systemd/journald.conf`
- `journalctl`, with options
  - `-b` boot msg.
  - `-u` filter 
  - `-k` kerenl msg.

## 3rd party agents
- Splunk - monitoring and log aggregation
- ElasticStack - used to collect, correlate and vidualize data
- AlienValut - SIEM tool
- Datadog - a monitoring platform for cloud applications, focusing on observability
