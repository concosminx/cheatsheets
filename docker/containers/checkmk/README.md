# CheckMK - network and systems monitoring


## Installation instructions

- create the folders `mkdir -p /docker/checkmk/monitoring`
- download the `docker-compose.yml` file
- run `docker-compose up -d && docker-compose logs -f` and get the default user and password
- install the agent with `sudo rpm -i agent.rpm` or `sudo yum localinstall agent.rpm` or `sudo dpkg -i agent.deb`
- check if the agent is running `systemctl --type=service` and `cmk-agent-ctl` command
- add the new hosts in the server (using the IP) or register with `cmk-agent-ctl` command
---------------------

Sources
- [youtube notes](https://shownotes.opensourceisawesome.com/checkmk/) 
- [official site](https://checkmk.com/)
