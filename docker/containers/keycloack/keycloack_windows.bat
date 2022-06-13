rem start keycloack with existing postgres db

docker stop keycloak

docker rm keycloak

docker run -e KEYCLOAK_USER=keycloakuser -e KEYCLOAK_PASSWORD=keycloakpswd ^
-p 8080:8080 -p 8443:8443 ^
-e DB_VENDOR=postgres ^
-e DB_ADDR=host.docker.internal ^
-e DB_PORT=5432 ^
-e DB_DATABASE=keycloak ^
-e DB_USER=keycloakdbuser ^
-e DB_PASSWORD=keycloakdbpswd ^
-d ^
--name keycloak ^
jboss/keycloak

