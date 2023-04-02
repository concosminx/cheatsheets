`/etc/sysctl.conf` - use to persist changes for kernel settings

- disable responding to ping `icmp_echo_ignore_broadcasts = 1`
- enable bridging (or NAT ...) `ip_forward = 1`
- persist bonding 

```sh
alias <bond name> bonding
options <bond name> mode=<mode #>
```
