# Start Keycloak server in production mode 

## Generate a self signed certificate in pem format in `./keycloak-config` folder 
```bash
openssl req -newkey rsa:2048 -nodes -keyout keycloak-server.key.pem -x509 -days 3650 -out keycloak-server.crt.pem
```

## Use an existing PostgreSQL instance or create a new container
```bash
docker run --name keycloak-db \
-v ./data-db:/var/lib/postgresql/data \
-d \
-e POSTGRES_PASSWORD=postgres \
-e POSTGRES_USER=postgres \
-e POSTGRES_DB="keycloak" \
-p 5432:5432 \
--restart unless-stopped \
postgres:14.9
```

## Create the docker container
```bash
docker run --name keycloak-server \
-p 8081:8080 -p 8443:8443 \
-e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin \
-d \
--restart unless-stopped \
-v ./keycloak-config:/opt/keycloak/conf \
-v ./keycloak-providers:/opt/keycloak/providers \
quay.io/keycloak/keycloak:18.0.2 \
 start \
 --auto-build \
 --db=postgres \
 --features=preview \
 --db-url=jdbc:postgresql://172.17.0.1:5432/keycloak \
 --db-username=postgres \
 --db-password=postgres \
 --https-certificate-file=/opt/keycloak/conf/keycloak-server.crt.pem \
 --https-certificate-key-file=/opt/keycloak/conf/keycloak-server.key.pem \
 --hostname-strict=false \
 --proxy=edge \
 --http-enabled=true \
```

## If logging is needed
```bash
 --log-level="INFO,org.hibernate:debug,org.hibernate.hql.internal.ast:info"
```