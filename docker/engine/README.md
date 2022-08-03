# Docker engine installation on centos 7/8

See [official documentation](https://docs.docker.com/engine/install/centos/).


- install prerequisites

`yum install dos2unix curl -y` - install dos2unix and curl

- download, convert and run the script

`curl http://...install_docker_engine.sh | dos2unix | sh` where [this](install_docker_engine.sh) is the script. 

- install docker compose [official documentation](https://docs.docker.com/compose/install/)
  

# Update 2022 - use these scripts from _Awesome Open Source_ YTB Channel

- ~~[deprecated github repo](https://github.com/bmcgonag/docker_installs)~~
- [current gitlab repo](https://gitlab.com/bmcgonag/docker_installs)
