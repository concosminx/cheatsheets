# OpenSSL commands

### check the running version
`openssl version -a`

### list the available commands
`openssl help`

### help for a specific command
`openssl rsa -h`

### benchmarking
`openssl speed` 

### benchmark remote connection
`openssl s_time -connect remote.host:443 -www /supadupa.html -new`

### generate a self-signed certificate
```bash
openssl req \
  -x509 -nodes -days 365 -sha256 \
  -newkey rsa:2048 -keyout mycert.pem -out mycert.pem
```

or without questions

```bash
openssl req \
  -x509 -nodes -days 365 -sha256 \
  -subj "/C=US/ST=California/L=LA/CN=www.supadupasite.com" \
  -newkey rsa:2048 -keyout mycert.pem -out mycert.pem
```

### generate a certificate request
```bash
openssl req \
  -new -sha256 -newkey rsa:2048 -nodes \
  -keyout mykey.pem -out myreq.pem
```

or without questions
```bash
openssl req \
  -new -sha256 -newkey rsa:2048 -nodes \
  -subj "/CN=www.supadupasite.com/O=Supa Dupa, Inc./C=US/ST=California/L=LA" \
  -keyout mykey.pem -out myreq.pem
```

and with existing key 

`openssl req -new -key mykey.pem -out myreq.pem`

verify signature `openssl req -in myreq.pem -noout -verify -key mykey.pem`

verify info `openssl req -in myreq.pem -noout -text`


### testing a new certificate 
`openssl s_server -cert mycert.pem -www` (where mycert.pem contains the key and certificate, combined)

Use browser to open `https://localhost:4433/`

### export a PKCS#12 certificate
```bash
openssl pkcs12 -export \
  -out mycert.pfx -in mycert.pem \
  -name "My Certificate"
```

### import PKCS#12 to PEM
- without passphrase `openssl pkcs12 -in mycert.pfx -out mycert.pem -nodes`
- with passphrase `openssl pkcs12 -in mycert.pfx -out mycert.pem`

### verify a certificate
`openssl verify cert.pem`


source material [here](https://www.madboa.com/geek/openssl/#how-do-i-find-out-what-openssl-version-im-running).