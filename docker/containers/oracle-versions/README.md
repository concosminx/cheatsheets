# Oracle Docker examples:


- [source](https://github.com/diemobiliar/minimized-oraclexe-image)

- run oracle XE18 container (AOO_TESTS/AOO_TESTS, sid: XE, memory: 288M < 1664M) 
  
```bash
docker run -d -e "SGA_TARGET=1024M" --name 18c_xe1024m -p 6789:1521 diemobiliar/minimized-oraclexe-image:18.4.0-xe
```

----------------

* [source](https://hub.docker.com/r/oracleinanutshell/oracle-xe-11g
)

- run oracle XE11 (system/oracle, sid: xe) 

```bash 
docker run -d -p 49161:1521 --name xe oracleinanutshell/oracle-xe-11g
```

----


- [source](https://hub.docker.com/r/gvenzl/oracle-xe)

```bash
docker stop myxedb

docker rm -f myxedb

docker pull gvenzl/oracle-xe

docker run --name myxedb  -d -p 1521:1521 -e ORACLE_PASSWORD=admin gvenzl/oracle-xe
```