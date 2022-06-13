#!/bin/bash

# uninstall old versions
yum remove -y docker \
                  docker-client \
				  docker-cli \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

# install the yum-utils package
# see https://docs.docker.com/storage/storagedriver/device-mapper-driver/
yum install -y yum-utils device-mapper-persistent-data lvm2

# set up the stable repository
yum-config-manager --add-repo http://download.docker.com/linux/centos/docker-ce.repo

# install the latest version of Docker Engine and containerd
yum install -y docker-ce docker-ce-cli containerd.io

# see https://medium.com/@anuketjain007/installation-of-docker-fails-on-centos-8-with-error-package-containerd-io-f7a338b34a71
# yum install -y https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm
# yum install -y docker-ce docker-ce-cli

# Docker is installed but not started. The docker group is created, but no users are added to the group
systemctl enable docker
systemctl start docker
systemctl status docker

# check docker version
docker version

# add new user to docker group
useradd dockuser
usermod -aG docker dockuser

# restart containers daily
echo 'docker restart $(docker ps -q)' > /etc/cron.daily/restart_docker.sh
chmod 765 /etc/cron.daily/restart_docker.sh
cat /etc/cron.daily/restart_docker.sh