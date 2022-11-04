# Basic Authentication with Nginx as a reverse proxy


## Build the image with

`docker build -t nginx-basic-auth .`

## Start a container based on previous build image
`docker run -it -p 80:80 --env BASIC_USERNAME=username --env BASIC_PASSWORD=password --env FORWARD_HOST=localhost --env FORWARD_PORT=8080 nginx-basic-auth`


## Docker compose example

```yml
services:
  application:
    image: httpd
    networks:
      - mynetwork

  nginx:
    image: nginx-basic-auth
    ports:
      - "80:80"
    depends_on:
      - application
    environment: 
      - FORWARD_HOST=application
      - FORWARD_PORT=80
      - BASIC_USERNAME=john
      - BASIC_PASSWORD=12345
    networks:
      - mynetwork

networks:
  mynetwork:
  ```