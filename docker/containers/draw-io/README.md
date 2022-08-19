# draw.io - diagrams.net (formerly [draw.io](https://hub.docker.com/r/jgraph/drawio)) 

- create a dir `mkdir -p /docker/drawio` and a docker-compose.yml file in that folder (`nano docker-compose.yml`):

```yaml
version: '3.5'
services:
  drawio:
    image: jgraph/drawio
    container_name: drawio
    restart: unless-stopped
    ports:
      - 8080:8080
      - 8443:8443 
    healthcheck:
      test: ["CMD-SHELL", "curl -f http://<your host private ip>:<your port from above> || exit 1"]
      interval: 1m30s
      timeout: 10s
      retries: 5
      start_period: 10s
```

- run `docker-compose up -d`