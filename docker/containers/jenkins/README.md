# Run jenkins on Docker with a custom image 

## Build the image
- create a new folder `mkdir -p /docker/jenkins` and download the files there
- run `docker build -t cosmin/jenkins .`

## run a container based on the image built earlier
- run `docker run -d -v jenkins_home:/var/jenkins_home --name jenkins -p 8080:8080 -p 50000:50000 --restart=on-failure --env JAVA_OPTS=-Dhudson.footerURL=http://mycompany.com cosmin/jenkins`