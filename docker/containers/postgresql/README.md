# Postgres DB with Docker

see [original postgres docker image](https://hub.docker.com/_/postgres)

# Create a custom network 
`docker network create custom-network-id`


# Launch a new container ~ Windows
- create a volume, needed for windows
`docker volume create custom-pg-volume`

- run the container
```bash
docker run -d ^
 --network custom-network-id ^
 --hostname custom-pg-service ^
 --name custom-pg-service ^
 -e POSTGRES_DB=db-name ^
 -e POSTGRES_PASSWORD=db-password ^
 -p 5432:5432 ^
 -v custom-pg-volume:/var/lib/postgresql/data ^
 --restart=unless-stopped ^
 postgres:14.3 postgres ^
 -c shared_buffers=1024MB ^
 -c max_connections=100
```

# Launch a new container ~ Linux
```bash
docker run -d \
 --network custom-network-id \
 --hostname custom-pg-service \
 --name custom-pg-service \
 -e POSTGRES_DB=db-name \
 -e POSTGRES_PASSWORD=db-password \
 -p 5432:5432 \
 -v /usr/local/pg-data-custom:/var/lib/postgresql/data \
 --restart=unless-stopped \
 postgres:14.3 postgres \
 -c shared_buffers=1024MB \
 -c max_connections=100
```