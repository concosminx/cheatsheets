#!/bin/bash
source .env && docker exec -it db1 mysqldump -uroot -p${DB_PASSWORD} --all-databases > ./back-up-db/mariadb-dump-$(date +%F_%H-%M-%S).sql

