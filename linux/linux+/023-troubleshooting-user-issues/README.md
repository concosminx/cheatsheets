# troubleshooting user issues

## local access
- `grep testuser /etc/passwd`
- `grep testuser /etc/shadow`
- check the last user login
  - `sudo last -f /var/log/wtmp | grep testuser`
  - `sudo lastlog -u testuser`
- `passwd -s testuser`
- `chage -l testuser`
- check `/etc/security/access.conf`

## remote access 
- network configuration
- server side ssh
- client side ssh
- remote desktop apps


