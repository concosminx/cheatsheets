# Jellyfin - Free Software Media System

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
