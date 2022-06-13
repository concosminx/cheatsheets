#!/bin/bash

docker stop keycloak

docker rm keycloak

docker run -e KEYCLOAK_USER=keycloakuser -e KEYCLOAK_PASSWORD=keycloakpswd \
-p 8443:8443 \
-e DB_VENDOR=postgres \
-e DB_ADDR=127.0.0.1 \
-e DB_PORT=5432 \
-e DB_DATABASE=keycloak \
-e DB_USER=keycloakdbuser \
-e DB_PASSWORD=keycloakdbpswd \
-d \
--restart unless-stopped \ 
--name keycloak \
jboss/keycloak:11.0.0

