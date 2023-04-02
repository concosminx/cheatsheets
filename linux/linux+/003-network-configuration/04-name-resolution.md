# centos | ubuntu

## check the host file 
`cat /etc/hosts`

## check the nsswitch.conf
`cat /etc/nsswitch.conf`

- search the lines with `hosts:`

## check host name resolution 
`cat /etc/resolv.conf`

- modify the files with `sudoedit`

# name resolution commands

## dig command

- `dig www.google.com`
- find the mail exchange `dig wwww.google.com google.com mx`
- find the name servers `dig www.google.com google.com ns`

## nslookup command

- `nsloockup dns.google.com`
- `nslookup 8.8.8.8`

## host command

- `host www.google.com`
