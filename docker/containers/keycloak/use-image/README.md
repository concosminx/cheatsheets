## Build the image

- `docker build . -t prebuilt_keycloak`

### Run a docker container from previous image

- `docker rm -f optimized_keycloak`
- `docker run --name optimized_keycloak -d -p 8443:8443 prebuilt_keycloak`


## Check the container 
- `docker exec -it optimized_keycloak bash`
- `docker logs optimized_keycloak`