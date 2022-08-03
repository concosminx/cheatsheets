# Jellyfin 

```bash
docker run -d \
--volume </path/to/your/>Jelllyfin/config:/config \
--volume </path/to/your/>Jelllyfin/cache:/cache \
--volume </full/path/to/your/media>:/media \
-p 8096:8096 \
--name=jellyfin \
--restart=unless-stopped \
jellyfin/jellyfin
```

or with docker-compose

```yaml
version: '3.3'
services:
    jellyfin:
        volumes:
            - '</path/to/your/>Jelllyfin/config:/config'
            - '</path/to/your/>Jelllyfin/cache:/cache'
            - '</full/path/to/your/media>:/media'
        ports:
            - '8096:8096'
        container_name: jellyfin
        restart: unless-stopped
        image: jellyfin/jellyfin
```