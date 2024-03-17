# Caddy + Ghost

1. create the networks
```
docker network create web
docker network create --internal caddy_internal
```


2. `docker-compose up -d` to run the stack 