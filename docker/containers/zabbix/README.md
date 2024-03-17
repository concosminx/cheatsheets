# zabbix server & agent installation

## server
1. clone the github [repo](https://github.com/zabbix/zabbix-docker.git)
2. start from an existing template like `cp docker-compose_v3_alpine_mysql_latest.yml docker-compose.yml`
3. modify the variables `cd env_vars` & `ls -lah`
4. check the available ports with `sudo lsof -i -P -n | grep LISTEN` and adjust the port mappings
5. run docker compose and check the logs `docker compose up -d && docker compose logs -f`
6. access the server ui (ip & port) and change the default credentials (Admin/zabbix)

## agent - Ubuntu
1. install with `apt install zabbix-agent`
2. check the configuration file at `/etc/zabbix/zabbix_agentd.conf`
3. modify the configuration file to reflect the actual server definitions (eg. hostname, ip(s))
4. start the service `systemctl start zabbix-agent`
5. enable the service `systemctl enable zabbix-agent`
6. check status for the service `systemctl status zabbix-agent`
7. take into account the fact that the server and agents must communicate based on IPs (see the case with docker)
