# CheckMK - network and systems monitoring


## Installation instructions

- create the folders `mkdir -p /docker/checkmk/monitoring`
- create a `docker-compose.yml` file with this content
```yml
version: '3.3'
services:
  check-mk-raw:
    ports:
      - '8085:5000'
    tmpfs: '/opt/omd/sites/cmk/tmp:uid=1000,gid=1000'
    volumes:
      - './monitoring:/omd/sites'
      - '/etc/localtime:/etc/localtime:ro'
    container_name: monitoring
    restart: always
    image: 'checkmk/check-mk-raw:master-daily'

networks:
  default:
    name: my-main-net
    external: true ```

- run `docker-compose up -d && docker-compose logs -f` and get the default user and password
- install the agent with `sudo rpm -i agent.rpm` or `sudo yum localinstall agent.rpm` or `sudo dpkg -i agent.deb`
- check if the agent is running `systemctl --type=service`



---------------------

Sources
- [youtube notes](https://shownotes.opensourceisawesome.com/checkmk/) 
- [official site](https://checkmk.com/)
