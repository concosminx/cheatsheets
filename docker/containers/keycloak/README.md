# Keycloak ready to run Docker commands

## Run legacy container on Windows

```bash
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
```

## Run legacy container on Linux 

```bash
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
```

To remove the container `docker rm -f keycloak`

## Run in dev mode - Quarkus ~ Windows 

```bash
docker run --name  -p 8080:8080 ^
-e KEYCLOAK_ADMIN=theadmin -e KEYCLOAK_ADMIN_PASSWORD=thepassword ^
-d ^
quay.io/keycloak/keycloak:latest ^
start-dev
```

# Run in dev mode - Quarkus ~ Linux
```bash
docker run --name keycloak_test -p 8080:8080 -p 8443:8443 \
-e KEYCLOAK_ADMIN=theadmin -e KEYCLOAK_ADMIN_PASSWORD=thepassword \
-d \
--restart unless-stopped \
quay.io/keycloak/keycloak:latest \
start-dev
```

## Run custom version in production mode - Quarkus ~ Windows | Linux
- certificate or keystore is needed
- generate a keystore 
`keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore server.keystore`

- run keycloak container on Windows

```bash
docker run --name keycloak -p 8080:8080 -p 8443:8443 ^
 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin ^
 -d ^
 --restart unless-stopped ^
 -v D:\cert:/opt/keycloak/conf ^
 -v D:\lib:/opt/keycloak/providers ^
 quay.io/keycloak/keycloak:18.0.0 ^
 start ^
 --auto-build ^
 --db=postgres ^
 --features=authorization,account2,impersonation,web-authn ^
 --db-url=jdbc:postgresql://host.docker.internal:5432/keycloak ^
 --db-username=postgres ^
 --db-password=postgres ^
 --hostname=localhost ^
 --https-key-store-file=/opt/keycloak/conf/server.keystore --https-key-store-password=password
```

- run keycloak container on Linux, with real certificate: 
    - use volumes: `-v /usr/local/keycloak/conf:/opt/keycloak/conf`
    - `-v /usr/local/keycloak/providers:/opt/keycloak/providers`
    - provide the certificate `--https-certificate-file=/opt/keycloak/conf/certfile.pem` and key `--https-certificate-key-file=/opt/keycloak/conf/keyfile.pem`