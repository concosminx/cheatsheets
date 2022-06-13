# nginx related snippets

## Run nginx with docker 

- `docker run -p 8080:80 -dt nginx`

## Create a centos image|container with systemd

- create the Dockerfile

```Dockerfile
FROM centos:8
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
```

- build the image

```bash
docker build --rm -t local/c8-systemd .
```

- example systemd enabled app container

```Dockerfile
FROM local/c8-systemd
RUN yum -y install httpd; yum clean all; systemctl enable httpd.service
EXPOSE 80
CMD ["/usr/sbin/init"]
```

- running a systemd enabled app container
```bash
docker run -ti --tmpfs /tmp --tmpfs /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 8080:80 local/c8-systemd
```

See: 
- [Official centos docker hub page](https://hub.docker.com/_/centos)
- [Stackoverflow question](https://stackoverflow.com/questions/36617368/docker-centos-7-with-systemctl-failed-to-mount-tmpfs-cgroup)


## Install nginx on Centos 8

- `docker run -dt centos:8` (see above info about using systemd)
- `docker commit [container-id] [image name]` - commit running container to image
- `rpm -qa | grep nginx` - check if nginx is installed
- `yum -y install nano` - install nano editor
- `yum -y install net-tools` - install tools like `netstat`
- `yum -y install epel-release` - install epel-release repo
- `yum -y install nginx` or `dnf install nginx` - install nginx
- `systemctl enable nginx` - enable the server (see problems with systemd)
- `systemctl start nginx` - start the server

Adjust the firewall rules: 

- `firewall-cmd --permanent --add-service=http`
- `firewall-cmd --permanent --list-all`
- `firewall-cmd --reload`

Check your ip

- `ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'`
- `curl -4 icanhazip.com` - external


Control the nginx process

- `systemctl status nginx` - check the server status
- `systemctl stop nginx` - stop the web server
- `systemctl start nginx` - start the web server
- `systemctl restart nginx` - stop & start the web server
- `systemctl reload nginx` - reload configuration without droping the connections
- `systemctl disable nginx` - disable auto start
- `systemctl enable nginx` - enable auto start
- `netstat -ntlp` - check the sockets
- `ps -ef --forest | grep nginx` - see the tree of processes (related to CPU/cores info `cat /proc/cpuinfo`)
- `cat /var/run/nginx.pid` - view process id of the master process

## Files and directories

- `/usr/share/nginx/html` - the web content
- `/etc/nginx` - Nginx configuration directory
- `/etc/nginx/nginx.conf` - the main Nginx configuration file
- `/etc/nginx/conf.d/` - server block configuration files, where you can define the websites that are hosted within Nginx
- `/var/log/nginx/access.log` - access log
- `/var/log/nginx/error.log` - error log

Change your host file (windows) to replace the ip with a hostname `[your_ip] example.com`.

## Configuration

- [example](https://www.nginx.com/resources/wiki/start/topics/examples/full/)
- `nginx -t ` - test the configuration
  
## Create a virtual host
- see `nginx.conf` for the default server configuration (or `default.conf` for older versions)
- `mkdir -p /var/www/your_domain/html` - create the directory for your_domain
- `chown -R $USER:$USER /var/www/your_domain/html` - assign ownership of the directory
- `nano /var/www/your_domain/html/index.html` - create a sample index.html
- add the html content: 

```html
<html>
    <head>
        <title>Welcome to your_domain</title>
    </head>
    <body>
        <h1>Success! Your Nginx server is successfully configured for <em>your_domain</em>. </h1>
        <p>This is a sample page.</p>
    </body>
</html>
```

- create the actual configuration `nano /etc/nginx/conf.d/your_domain.conf`

```nginx
server {
    listen 80;
    listen [::]:80;

    root /var/www/your_domain/html;
    index index.html index.htm index.nginx-debian.html;

    server_name yourdomain.com;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

- test the configuration with `nginx -t`
- restart the server `systemctl restart nginx`
- update your server’s SELinux security contexts `chcon -vR system_u:object_r:httpd_sys_content_t:s0 /var/www/your_domain/`

# Reverse proxy configuration

- see [docs](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/)
- configure the proxy server: 

```nginx
server {
    listen 80;
    listen [::]:80;

    server_name myproxy.com;

    location / {
      proxy_set_header Host $host; 
      proxy_set_header X-Real-IP $remote_addr;
      proxy_pass http://172.17.0.2;
    }
}
```

# Load balancer configuration

- see [docs](http://nginx.org/en/docs/http/load_balancing.html)
- configure like this: 

```nginx 
http {
    upstream myapp1 {
        #round_robin, least_conn or ip_hash - as methods
        server srv1.example.com; #.. max_fails=2 fail_timeout=30s;
        server srv2.example.com; #.. weight=5;
        server srv3.example.com;
    }

    server {
        listen 80;

        location / {
            proxy_pass http://myapp1;
        }
    }
}
```

# Caching

- check the cache in Mozilla `about:cache`
- add cache control headers - see [docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Cache-Control) and [blog](https://www.cloudsavvyit.com/3782/how-to-configure-cache-control-headers-in-nginx/): 

```nginx 
location ~ \.(png) {
    root /var/www/websites/;
    add_header Cache-Control no-store;
}

location ~ \.(html {
    root /var/www/websites/;
    add_header Cache-Control private max-age:200;
    add_header Cache-Control public  s-maxage:500;
    add_header Cache-Control no-cache must-revalidate;
}
```

# Serving static content from the reverse proxy
- see the [docs](https://docs.nginx.com/nginx/admin-guide/web-server/serving-static-content/)

# Security control
- see the [docs](https://docs.nginx.com/nginx/admin-guide/security-controls/)
- example:

```nginx
location /accounts/login {
   allow 99.11.23.21;
   deny all;
}
```

- basic auth example - [docs](https://docs.nginx.com/nginx/admin-guide/security-controls/configuring-http-basic-authentication/): 

```nginx
http {
    server {
        listen 8080;
        root   /usr/share/nginx/html;

        location /api {
            api;
            satisfy all;

            allow 192.168.1.1/24;
            allow 127.0.0.1;
            deny  all;

            auth_basic           "Baic auth";
            auth_basic_user_file /etc/nginx/.htpasswd; 
        }
    }
}
```
- create the `htpasswd` file using: `htpasswd -c /etc/nginx/.htpasswd newusername`

- limit connections - [docs](https://www.nginx.com/blog/tuning-nginx/#limit_conn)
- example:

```nginx
location /flv/ {
    flv;
    limit_rate_after 500k;
    limit_rate       50k;
}
```

# Compression 

- see [docs](https://docs.nginx.com/nginx/admin-guide/web-server/compression/)

# HTTPS

- see [docs](http://nginx.org/en/docs/http/configuring_https_servers.html)
- see `/etc/nginx/nginx.conf` for default ssl config
- create a self signed certificate with `openssl`:

```bash
openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 365 -nodes

#fill in the details

mv cert.pem final.pem
cp * /etc/ssl/certs

#modify the nginx.conf
```

```nginx
server {
    listen 443;
    server_name example.com;

    ssl on;
    ssl_certificate /etc/ssl/certs/final.pem;
    ssl_certificate_key /etc/ssl/certs/key.pem;

    ssl_session_timeout 5m;

    # enables SSLv3/TLSv1, but not SSLv2 which is weak and should no longer be used.
    ssl_protocols SSLv3 TLSv1;
    ...
}
```
