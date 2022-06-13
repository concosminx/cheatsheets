## Configure mutual TLS in tomcat

See [official](https://www.keycloak.org/server/enabletls) guide and [original youtube video](https://www.youtube.com/watch?v=yq1hzNs1JQU)

### Create your own CA

`openssl req -new -newkey rsa:4096 -days 365 -extensions v3_ca -subj "/C=RO/ST=AG/L=Pitesti/O=ACMESRL/OU=LC/CN=*.acme.com/" -nodes -x509 -sha256 -set_serial 0 -keyout ca.key -out ca.crt`

### Import the CA in a truststore
`keytool -import -file ca.crt -keystore ca.truststore -keypass bestpassword -storepass bestpassword`

### Host certificate 
`openssl req -new -newkey rsa:4096 -keyout localhost.key -out localhost.csr -nodes -subj "/C=RO/ST=AG/L=Pitesti/O=ACMESRL/OU=LC/CN=*.acme.com/"`

or (not tested)

`openssl req -newkey rsa:4096 -nodes -sha256 -subj "/C=RO/ST=AG/L=Pitesti/O=ACMESRL/OU=LC/CN=*.acme.com/" -keyout localhost.key -out localhost.csr -config openssl-san.cnf`

### Sign the request
`openssl x509 -req -CA ca.crt -CAkey ca.key -in localhost.csr -out localhost.crt -days 365 -CAcreateserial -extfile localhost.ext`

### Create a client certificate for browser
`openssl req -new -newkey rsa:4096 -nodes -keyout johnDoe.key -out johnDoe.csr -subj "/C=RO/ST=AG/L=Pitesti/O=ACMESRL/OU=LC/CN=*.acme.com/emailAddress=john@email.com/"`

### Sign the client certificate with CA
`openssl x509 -req -CA ca.crt -CAkey ca.key -in johnDoe.csr -out johnDoe.crt -days 365 -CAcreateserial`

### Import client key and client crt in keystore (for browser)
`openssl pkcs12 -export -out johnDoe.p12 -name "John Doe" -inkey johnDoe.key -in johnDoe.crt -passout pass:bestpassword`

### Check certificate
`openssl x509 -text -noout -in johnDoe.crt`

### Run the container (Windows)

```bash
docker run --name keycloak -p 8080:8080 -p 8443:8443 \
-e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin \
-d \
-v /home/cosmin/Keycloak:/opt/keycloak/conf \
--restart unless-stopped \
quay.io/keycloak/keycloak:17.0.1 \
start \
--auto-build \
--db=postgres \
--features=authorization,account2,impersonation,web-authn \
--db-url=jdbc:postgresql://172.17.0.1:5432/mydb \
--db-username=postgres \
--db-password=postgres \
--hostname=localhost \
--https-client-auth=request \
--https-certificate-file=/opt/keycloak/conf/localhost.crt \ --https-certificate-key-file=/opt/keycloak/conf/localhost.key \
--https-trust-store-file=/opt/keycloak/conf/ca.truststore \ --https-trust-store-password=bestpassword
```