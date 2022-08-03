# Traefik

1. Start a container
```bash
docker run -d -p 8080:8080 -p 80:80 \
-v $PWD/traefik.yml:/etc/traefik/traefik.yml \
-v /var/run/docker.sock:/var/run/docker.sock \
traefik:v2.5
```

2. Start a Backend server
```bash
docker run -d --name test traefik/whoami
```

3. test the web ui
`http://localhost:8080`