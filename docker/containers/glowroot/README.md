Check the official docs [here](https://github.com/glowroot/glowroot/wiki)

# Embedded collector
1. Download a distribution from the github [repo](https://github.com/glowroot/glowroot/releases)
2. Add the agent to application (u can use JAVA_OPTS) `-javaagent:path/to/glowroot.jar`
3. Start the app and check the information at `http://localhost:4000`

# Central collector
## Server with Docker
1. Create a `docker-compose.yml` file with:
```yaml
version: '3.7'

services:

  glowroot:
    image: glowroot/glowroot-central:0.14.0
    ports:
      - "8181:8181/tcp"
      - "4000:4000/tcp"
    environment:
      CASSANDRA_CONTACT_POINTS: cassandra
    networks:
      - glowroot_net

  cassandra:
    image: cassandra:4.1.1
    ports:
      - "7000:7000/tcp"
      - "9160:9160/tcp"
      - "9042:9042/tcp"
    volumes:
      - cassandra_data:/var/lib/cassandra
    networks:
      - glowroot_net

networks:
  glowroot_net:
volumes:
  cassandra_data:
    driver: local
```
2. Run `docker compose up -d`

## Agent
1. Similar with the embedded collector, but you need to create `glowroot.properties` in the same directory as the agent with:
```properties
agent.id=
collector.address=
```
where `collector.address` should point to the host grpc port of the collector.
