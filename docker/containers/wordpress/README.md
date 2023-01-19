# Install WordPress with Docker

## Create a new folder and cd into
`mkdir wordpress-compose && cd wordpress-compose`

## Create a new docker-compose.yml file
`nano docker-compose.yml`

## Copy the example in docker-compose.yml and modify it (see also [backup](https://hub.docker.com/r/databack/mysql-backup))

```yaml
version: "3.7"
services:
  wordpress:
    image: wordpress:${WP_VERSION}
    restart: always
    links:
     - mariadb:mysql
    environment:
     - WORDPRESS_DB_PASSWORD=${DB_PASSWORD}
     - WORDPRESS_DB_USER=${DB_USER}
    ports:
    - "8091:80"
    volumes:
     - ./html:/var/www/html
  mariadb:
    image: mariadb:${DB_VERSION}
    restart: always
    environment:
     - MYSQL_ROOT_PASSWORD=${DB_PASSWORD}
     - MYSQL_DATABASE=${DB_NAME}
    volumes:
     - ./database:/var/lib/mysql
  backup:
    image: databack/mysql-backup:master
    user: "0"
# https://github.com/databacker/mysql-backup/pull/62/commits/14e971148c44e66755e4a2116534ccff00286a78
    depends_on:
     - mariadb
    restart: always
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - ./db-back-up:/db
      - ./pre-backup/scripts:/scripts.d/pre-backup
      - ./post-backup/scripts:/scripts.d/post-backup
    environment:
     - DB_DUMP_TARGET=/db
     - DB_PORT=3306
     - DB_USER=${DB_USER}
     - DB_PASS=${DB_PASSWORD}
     - DB_DUMP_FREQ=1440
     - DB_DUMP_BEGIN=+1
     - DB_SERVER=mariadb

networks:
  default:
    name: my-main-net
    external: true 

```