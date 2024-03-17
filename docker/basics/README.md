Index

- [Check the docker version](#check-the-docker-version)
- [Containers](#containers)
	- [Lifecycle](#lifecycle)
	- [Starting and Stopping](#starting-and-stopping)
	- [Info](#info)
	- [Import / Export](#import--export)
	- [Executing Commands](#executing-commands)
- [Images](#images)
	- [Lifecycle](#lifecycle-1)
	- [Info](#info-1)
	- [Cleaning up](#cleaning-up)
- [Networks](#networks)
	- [Lifecycle](#lifecycle-2)
	- [Info](#info-2)
	- [Connection](#connection)
- [Registry \& Repository](#registry--repository)
- [Dockerfile](#dockerfile)
	- [Instructions](#instructions)
- [Volumes](#volumes)
	- [Lifecycle](#lifecycle-3)
	- [Info](#info-3)
- [Exposing ports](#exposing-ports)
- [Prune](#prune)
- [CheatSheet](#cheatsheet)
	- [Linux](#linux)
	- [Powershell (windows)](#powershell-windows)
	- [Cleanup for windows (.bat)](#cleanup-for-windows-bat)
- [Docker file example](#docker-file-example)
	- [Example of a docker file](#example-of-a-docker-file)
	- [Docker compose](#docker-compose)

# Check the docker version

- [`docker version`](https://docs.docker.com/engine/reference/commandline/version/)
  
# Containers

## Lifecycle

- [`docker create`](https://docs.docker.com/engine/reference/commandline/create/) - creates a container (without starting it)
  
- [`docker rename`](https://docs.docker.com/engine/reference/commandline/rename/) - allows the container to be renamed

- [`docker run`](https://docs.docker.com/engine/reference/commandline/run/) - creates ant starts a container 

- [`docker rm`](https://docs.docker.com/engine/reference/commandline/rm/) - deletes a container 

- [`docker update`](https://docs.docker.com/engine/reference/commandline/update/) - update a container's resource limits 

Keep container running `docker run -td continer_id` (`-t` will alocate a pseudo-TTY session and `-d` will detach automatically the container (run container in background and print condainer id).

Transient container: `docker run --rm` will remove the container after it stops.

If you want to map a directory on the host to a docker container use: `docker run -v $HOSTDIR:$DOCKERDIR` (volumes).

If you want to remove also the volumes associated with the container: `docker rm -v`

Another useful option is `docker run --name yourname docker_image` - this will allow you to start and stop a container by calling it with the name the you specified when you created it

## Starting and Stopping

- [`docker start`](https://docs.docker.com/engine/reference/commandline/start/) - starts a container 

- [`docker stop`](https://docs.docker.com/engine/reference/commandline/stop/) - stops a running container 

- [`docker restart`](https://docs.docker.com/engine/reference/commandline/restart/) - stops and starts a container 

- [`docker pause`](https://docs.docker.com/engine/reference/commandline/pause) - pauses a running container 

- [`docker unpause`](https://docs.docker.com/engine/reference/commandline/unpause/) - will unpause a running container 

- [`docker wait`](https://docs.docker.com/engine/reference/commandline/wait/) - blocks until running container stops 

- [`docker kill`](https://docs.docker.com/engine/reference/commandline/kill/) - sends a SIGKILL to a running container 

- [`docker attach`](https://docs.docker.com/engine/reference/commandline/attach) - connect to a running container 

If you want to detach use: `Ctrl + P, Ctrl + Q`  

## Info 


- [`docker ps`](https://docs.docker.com/engine/reference/commandline/ps) - shows running containers

- [`docker logs`](https://docs.docker.com/engine/reference/commandline/logs) - gets logs from container

- [`docker inspect`](https://docs.docker.com/engine/reference/commandline/inspect) - looks at all the info on a container (including IP address)
  
- [`docker events`](https://docs.docker.com/engine/reference/commandline/events) - gets events from container

- [`docker port`](https://docs.docker.com/engine/reference/commandline/port) - shows public facing port of container

- [`docker top`](https://docs.docker.com/engine/reference/commandline/top) - shows running processes in container

- [`docker stats`](https://docs.docker.com/engine/reference/commandline/stats) - shows containers' resource usage statistics

- [`docker diff`](https://docs.docker.com/engine/reference/commandline/diff) - shows changed files in the container's FS

- `docker ps -a` shows running and stopped containers.

- `docker stats --all` shows a list of all containers, default shows just running.

## Import / Export

- [`docker cp`](https://docs.docker.com/engine/reference/commandline/cp>) - copies files or folders between a container and the local filesystem
  
- [`docker export`](https://docs.docker.com/engine/reference/commandline/export) - turns container filesystem into tarball archive stream to STDOUT

## Executing Commands


- [`docker exec`](https://docs.docker.com/engine/reference/commandline/exec) - to execute a command in container

To enter a running container, attach a new shell process to a running container called foo, use: `docker exec -it foo /bin/bash`.

# Images 

## Lifecycle

- [`docker images`](https://docs.docker.com/engine/reference/commandline/images) - shows all images

- [`docker import`](https://docs.docker.com/engine/reference/commandline/import) - creates an image from a tarball

- [`docker build`](https://docs.docker.com/engine/reference/commandline/build) - creates image from Dockerfile

- [`docker commit`](https://docs.docker.com/engine/reference/commandline/commit) - creates image from a container, pausing it temporarily if it is running

- [`docker rmi`](https://docs.docker.com/engine/reference/commandline/rmi) - removes an image

- [`docker load`](https://docs.docker.com/engine/reference/commandline/load) - loads an image from a tar archive as STDIN, including images and tags 

- [`docker save`](https://docs.docker.com/engine/reference/commandline/save) - saves an image to a tar archive stream to STDOUT with all parent layers, tags & versions 

## Info


- [`docker history`](https://docs.docker.com/engine/reference/commandline/history) - shows history of image

- [`docker tag`](https://docs.docker.com/engine/reference/commandline/tag) - tags an image to a name (local or registry)

## Cleaning up

- `docker rmi` command to remove specific images
- containers `docker rm -f $(docker ps -q)`
- images `docker rmi $(docker images -q)`



# Networks

Docker has a [`networks`](https://docs.docker.com/engine/userguide/networking/) feature. 

## Lifecycle


- [`docker network create`](https://docs.docker.com/engine/reference/commandline/network_create/)
   
- [`docker network rm`](https://docs.docker.com/engine/reference/commandline/network_rm/) 

## Info

- [`docker network ls`](https://docs.docker.com/engine/reference/commandline/network_ls/)
  
- [`docker network inspect`](https://docs.docker.com/engine/reference/commandline/network_inspect) 

## Connection

- [`docker network connect`](https://docs.docker.com/engine/reference/commandline/network_connect/) 
- [`docker network disconnect`](https://docs.docker.com/engine/reference/commandline/network_disconnect/)

# Registry & Repository


- [`docker login`](https://docs.docker.com/engine/reference/commandline/login) - to login to a registry

- [`docker logout`](https://docs.docker.com/engine/reference/commandline/logout) - to logout from a registry

- [`docker search`](https://docs.docker.com/engine/reference/commandline/search) - searches registry for image

- [`docker pull`](https://docs.docker.com/engine/reference/commandline/pull) - pulls an image from registry to local machine

- [`docker push`](https://docs.docker.com/engine/reference/commandline/push) - pushes an image to the registry from local machine

# Dockerfile

[`The configuration file`](https://docs.docker.com/engine/reference/builder/) - sets up a Docker container when you run `docker build` on it

## Instructions

- [`.dockerignore`](https://docs.docker.com/engine/reference/builder/#dockerignore-file)
  
- [`FROM`](https://docs.docker.com/engine/reference/builder/#from) - Sets the Base Image for subsequent instructions.

- [`MAINTAINER`](https://docs.docker.com/engine/reference/builder/#maintainer-deprecated) - Set the Author field of the generated images. Deprecated - use LABEL instead.

- [`RUN`](https://docs.docker.com/engine/reference/builder/#run) - execute any commands in a new layer on top of the current image and commit the results.

- [`CMD`](https://docs.docker.com/engine/reference/builder/#cmd) - provide defaults for an executing container.

- [`EXPOSE`](https://docs.docker.com/engine/reference/builder/#expose) - informs Docker that the container listens on the specified network ports at runtime.  NOTE: does not actually make ports accessible.

- [`ENV`](https://docs.docker.com/engine/reference/builder/#env) - sets environment variable.

- [`ADD`](https://docs.docker.com/engine/reference/builder/#add) - copies new files, directories or remote file to container.  Invalidates caches. Avoid `ADD` and use `COPY` instead.

- [`COPY`](https://docs.docker.com/engine/reference/builder/#copy) - copies new files or directories to container.  By default this copies as root regardless of the USER/WORKDIR settings.  Use `--chown=<user>:<group>` to give ownership to another user/group.  (Same for `ADD`.)

- [`ENTRYPOINT`](https://docs.docker.com/engine/reference/builder/#entrypoint) - configures a container that will run as an executable.

- [`VOLUME`](https://docs.docker.com/engine/reference/builder/#volume) - creates a mount point for externally mounted volumes or other containers.

- [`USER`](https://docs.docker.com/engine/reference/builder/#user) - sets the user name for following RUN / CMD / ENTRYPOINT commands.

- [`WORKDIR`](https://docs.docker.com/engine/reference/builder/#workdir) - sets the working directory.

- [`ARG`](https://docs.docker.com/engine/reference/builder/#arg) - defines a build-time variable.

- [`ONBUILD`](https://docs.docker.com/engine/reference/builder/#onbuild) - adds a trigger instruction when the image is used as the base for another build.

- [`STOPSIGNAL`](https://docs.docker.com/engine/reference/builder/#stopsignal) - sets the system call signal that will be sent to the container to exit.

- [`LABEL`](https://docs.docker.com/config/labels-custom-metadata/) - apply key/value metadata to your images, containers, or daemons.

# Volumes

Docker volumes are [`free-floating filesystems`](https://docs.docker.com/engine/tutorials/dockervolumes/) - They don't have to be connected to a particular container.

## Lifecycle


- [`docker volume create`](https://docs.docker.com/engine/reference/commandline/volume_create/) 
- [`docker volume rm`](https://docs.docker.com/engine/reference/commandline/volume_rm/) 

## Info


- [`docker volume ls`](https://docs.docker.com/engine/reference/commandline/volume_ls/) 
- [`docker volume inspect`](https://docs.docker.com/engine/reference/commandline/volume_inspect/) 

Volumes are useful in situations where you can't use links (which are TCP/IP only). For instance, if you need to have two docker instances communicate by leaving stuff on the filesystem.

You can mount them in several docker containers at once, using `docker run --volumes-from`.


# Exposing ports

Exposing incoming ports through the host container is [`doable`](https://docs.docker.com/engine/reference/run/#expose-incoming-ports) -

This is done by mapping the container port to the host port (only using localhost interface) using `-p`:

`docker run -p 127.0.0.1:$HOSTPORT:$CONTAINERPORT --name CONTAINER -t someimage`

You can tell Docker that the container listens on the specified network ports at runtime by using [`EXPOSE`](https://docs.docker.com/engine/reference/builder/#expose) 

`EXPOSE <CONTAINERPORT>`

Note that EXPOSE does not expose the port itself -- only `-p` will do that. To expose the container's port on your localhost's port:

` iptables -t nat -A DOCKER -p tcp --dport <LOCALHOSTPORT> -j DNAT --to-destination <CONTAINERIP>:<PORT> `

If you forget what you mapped the port to on the host container, use `docker port` to show it:

`docker port CONTAINER $CONTAINERPORT`

# Prune
- `docker system prune`
- `docker volume prune`
- `docker network prune`
- `docker container prune`
- `docker image prune`


# CheatSheet

## Linux

* kill all running containers: `docker kill $(docker ps -q)`
* view the logs of running container: `docker logs <container name | id>`
* remove all stopped containers (add `-f` to remove also the running ones): `docker rm $(docker ps -a -q)`
* remove all docker images: `docker rmi $(docker images -q)`
* remove all untagged (dangling) docker images: `docker rmi $(docker images -q -f dangling=true)`
* remove volumes (dangling): `docker volume rm -f $(docker volume ls -f dangling=true -q)`
* bash shell in the running container: `sudo docker exec -it <container name> bash`
* save a running docker container to a image: `docker commit <image name> <name for image>`


## Powershell (windows)

- remove all containers: `docker ps -a -q | % { docker rm $_ }`
- remove all images: `docker images -q | % { docker rmi $_ }`

## Cleanup for windows (.bat)

[script](docker-clean.bat)


# Docker file example

## Example of a docker file 

- nginx wih static html example

```Dockerfile
 # Use an official nginx image as a parent image
 FROM nginx:1.14

 # Copy the test html over the default nginx welcome page
 COPY hWorld.html /usr/share/nginx/html/index.html

 # Document the availability of the http port 80
 EXPOSE 80
```
- build the image: `docker build -t hWorld .`

- running a image: `docker run -p 9999:80 hWorld`

- executing commands: 
	- `docker exec -t <containerid/name> ls -lah /` - prints the root directory of the container in a list form
	- `docker exec -it <containerid/name> bash` - `-it` enables an interactive mode
  

  

## Docker compose

* start a group of containers from `docker-compose.yml` file: `docker-compose up -d`
* fetch the lastest version: `docker-compose up -d – force-recreate`
* or use a group of commands: 
  
```bash
docker-compose stop -t 1
docker-compose rm -f
docker-compose pull
docker-compose build
docker-compose up -d
```
* view logs: `docker-compose logs -f`



