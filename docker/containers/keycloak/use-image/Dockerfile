FROM quay.io/keycloak/keycloak:latest as builder

COPY lib/custom-themes.jar /opt/keycloak/providers/custom-themes.jar
COPY lib/custom1.jar /opt/keycloak/providers/custom1.jar
COPY lib/custom2.jar /opt/keycloak/providers/custom2.jar
ENV KC_METRICS_ENABLED=true
ENV KC_FEATURES=authorization,account2,impersonation,web-authn
ENV KC_DB=postgres
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest
COPY --from=builder /opt/keycloak/lib/quarkus/ /opt/keycloak/lib/quarkus/
COPY --from=builder /opt/keycloak/providers/ /opt/keycloak/providers/
WORKDIR /opt/keycloak
# use proper certificates in production instead
RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore conf/server.keystore
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin
# change these values to point to a running postgres
ENV KC_DB_URL=jdbc:postgresql://host.docker.internal:5432/keycloak
ENV KC_DB_USERNAME=postgres
ENV KC_DB_PASSWORD=keycloakdbpass
ENV KC_HOSTNAME=localhost
ENTRYPOINT ["/opt/keycloak/bin/kc.sh","--verbose","start"]