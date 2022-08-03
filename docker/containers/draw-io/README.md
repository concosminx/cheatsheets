# draw.io

```yaml
#This compose file adds diagrams.net (ex draw.io) to your stack
version: '3.5'
services:
  drawio:
    image: jgraph/drawio
    container_name: drawio
    restart: unless-stopped
    ports:
      - 8080:8080  # you can change teh left side of the colon to an open port on your host.
      - 8443:8443  # you can change teh left side of the colon to an open port on your host.
    healthcheck:
      test: ["CMD-SHELL", "curl -f http://<your host private ip>:<your port from above> || exit 1"]
      interval: 1m30s
      timeout: 10s
      retries: 5
      start_period: 10s
```      