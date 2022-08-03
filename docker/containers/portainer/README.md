# Portainer

- [docs](https://docs.portainer.io/start/install/server/docker/linux)
- create a volume `docker volume create portainer_data`
- install the community edition `docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest`
- connect with `https://ip::9443`