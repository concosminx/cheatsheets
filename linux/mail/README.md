# Configuring Gmail as a Sendmail email relay

## Install Sendmail
- `sudo apt install sendmail mailutils sendmail-bin`

## Create Gmail authentication file
- elevate to root user `sudo -i`
- make a new directory where we will store the Gmail configuration file:
```bash
mkdir -m 700 /etc/mail/authinfo/
cd /etc/mail/authinfo/
```
- create a new file that will contain our authentication info: `nano gmail-auth`
- paste the following template and then edit it with your own information `AuthInfo: "U:root" "I:YOUR GMAIL EMAIL ADDRESS" "P:YOUR PASSWORD"`
- create a hash map for the above authentication file `makemap hash gmail-auth < gmail-auth`

## Configure Sendmail
- edit the file in `/etc/mail/sendmail.mc`: `nano /etc/mail/sendmail.mc`
- paste the following lines right above first `MAILER` definition line:
```bash
define(`SMART_HOST',`[smtp.gmail.com]')dnl
define(`RELAY_MAILER_ARGS', `TCP $h 587')dnl
define(`ESMTP_MAILER_ARGS', `TCP $h 587')dnl
define(`confAUTH_OPTIONS', `A p')dnl
TRUST_AUTH_MECH(`EXTERNAL DIGEST-MD5 CRAM-MD5 LOGIN PLAIN')dnl
define(`confAUTH_MECHANISMS', `EXTERNAL GSSAPI DIGEST-MD5 CRAM-MD5 LOGIN PLAIN')dnl
FEATURE(`authinfo',`hash -o /etc/mail/authinfo/gmail-auth.db')dnl
```
- re-build sendmail’s configuration: `make -C /etc/mail`
- reload the Sendmail service: `systemctl restart sendmail` and check the service status `systemctl status sendmail`

## Configuration test
- `echo "Testing my sendmail gmail relay" | mail -s "Sendmail gmail Relay" myemail@somehost.com`
