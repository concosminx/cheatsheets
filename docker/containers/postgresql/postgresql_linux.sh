#!/bin/bash

docker run --name mypginstance -v my-data:/var/lib/postgresql/data -d -e POSTGRES_PASSWORD=postgres -p 5432:5432 -e POSTGRES_DB="mydb" postgres

# see logs
# docker logs mypginstance

# connect to container and ...
# docker exec -it mypginstance sh

# create another database 
# createdb -U postgres mydb2

# use posgres CLI tools 
# psql -U postgres mydb2
# \l
# select version();
# \q

#check created volume
# docker volume inspect my-data

#stop and remove 
#docker rm -f mypginstance
#docker volume rm postgres-data