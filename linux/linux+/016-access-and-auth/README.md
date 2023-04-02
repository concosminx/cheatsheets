# access and authentication 

## PAM 
- pluggable authentication modules
- centralized authentication services
- modular
- `libpam.so`
- `/etc/pam.d/sshd`
- `TYPE CONTROL-FLAG PAM-MODULE MODULE-OPTIONS`
- type can be: 
  - account
  - auth 
  - password
  - session
- control flag can be:
  - required
  - requisite
  - sufficient
  - optional
- example `/etc/pam.d/sshd` in ubuntu

## PAM utilities and policies
- `pam_unix.so `
  - authentication using account data in `/etc/password` and password data stored in `/etc/shadow`
- `pam_pwhistory.so`
  - checks a user's new password against a password history file to prevent reuse
- `pam_pwquality.so`
  - enforces password complexity rules
- `pam_ldap.so`
  - used for LDAP integration
  - `/etc/ldap.conf`
  - `/etc/pam.d/system-auth` (Centos)
  - `pam-auth-update` (Ubuntu)
- `pam_tally2.so` 
  - limit failed login attempts
  - `auth required pam_tally2.so deny=5 onerr=fail`
  - `account required pam_tally2.so`
  - root user can run `/sbin/pam_tally2` to view the failed logins
- `pam_faillock.so`
  - another option to limit failed login attempts
  - configured in `/etc/pam.d/system-auth` and `/etc/pam.d/password-auth`
  - `faillock` command can be run by root


## SSH (as a client)
- to connect to a remote server
- uses asymmetric encryption (public/private keys)
- during connection establishment eeach end of SSH connection exchanges public keys

### OpenSSH 
- most commonly installed
- process: 
  - SSH is used to login as user@remote-host
  - has user ever used SSH
    - no: create known_hosts file in ~/.ssh
    - yes: have you ever connected to this remote-host
      - no: prompt user to add remote-host public key to known_hosts
      - yes: prompt user for password to remote-host
- known_host 
  - used to track remote hosts (contains the public keys)
  - `~/.ssh/known_hosts`
  - `hostname(or IP) key type public key` - the record structure
- `~/ssh/config` 
  - configuration file
  - we can setup `Identity File ~/.ssh/id_rsa`
- `/etc/ssh/ssh_config` - client configuration settings
- `/etc/ssh/sshd_config` - server or OpenSSH (sshd) daemon configurations

### Keys and utilities
- `ssh-keygen` 
  - utility to create key pairs
  - the private and public key are created and stored in the `~/.ssh` and the default names are
    - `~/.ssh/id_rsa` - private key (identification key)
    - `~/.ssh/id_rsa.pub` - public key
  - options 
    - `-b`: key size
    - `-t`: key type
    - `-C`: add a comment (eg. email address)
    - example: `ssh-keygen -t rsa -b 4096 -C "email@mails.com"`
    - recommended to provide a password
- `ssh-copy-id user@remote-host` - get the public key to the remote server
  - `ssh-copy-id -n user@remote-host` - dry run
  - prompts the user for their password
  - stores the public key on the system in the `authorized_keys` file on the remote host `~/.ssh/authorized_keys`
  - if the `shs-copy-id` is not available the user can login and create the file on the remote system
- `ssh-add` - used when the key is password protected
  - uded along with `ssh-agent`
    - eval `ssh-agent`
    - `ssh-add`
    - enter the password
    - passwordless from now on

## TCP wrappers
- replaces by firewalls
  
## TTY and PTY 
- `tty`
  - subsystem for terminal access
  - it's a device file
  - 2 types:
    - `tty` terminal 'the real tty'
      - direct access to the system 
      - found at `/dev/tty#`
    - `pty` terminal 'pseudo-tty'
      - accessed by a terminal app running in a GUI
      - could be remotely accessed fron an SSH session
      - found at `/dev/pts/*`
- best practice 
  - use `sudo` instead of root login
  - limit the locations where the root user can login - can be configured using a PAM module (pam_securetty.so) and modify `/etc/securetty`
  - change to tty1 `Alt+F1` ... `Alt+F12` u can restrict only to these ones (soo ... root has only phisical access)

## public key infrastructure
- PKI - provides integrity for cryptography through a group of components:
  - private keys
  - public/private key pairs
  - certificate authority (CA)
- uses asymmetric encryption:
  - a public key known by everyone
    - can only be decrypted by the private key
  - a private key is ONLY known by the owner
    - can only be decrypted by public key
  - by comparison, a symmetric key is a single key known by both parties
  - generally asymmetric encryption is used to establish a trusted connection and then share a symmetric key
- a CA issues digital certificates that validate a server's identity: VeriSign, Comod, DigiCert
  - digital certificates are either issued or signed by a CA
  - a certificate is an *encrypted key*
  - the CA signs the certificate it issues with it's own private key
    - sooo ... private key can only be decrypted by a public key
    - everyone has access to the public key
    - therefore everyone can decrypt the signature of the CA and
    - by decrypyting the signature they verify the authenticity of the issued certificate
- self signed certificate
  - should not be used in production 
  - used in any external/public facing sites
- hashing
  - one way alghoritm to turn plain text into cipher text
  - the cipher text is called: hash, digest, or fingerprint
  - use it to compare data
- digital signature
  - is a message digest of the plain-text data
  - the user's private key is added to this hash, or message digest

## VPN as a client
- VPN is better for connecting remotely to a resource 
- establishes a secure encrypted connection over a public network
- it's levereages PKI to authenticate and communicate with a VPN server
- protocoles
  - IPSec - internet protocol security
    - AH - Authentication Headers 
    - ESP - Encapsulating Security Payload
    - ISAKMP - key management
    - modes: tunnel or transport
  - SSL/TLS
    - a VPN client should use at least TLS 1.2
  - DTLS
    - Datagram Transport Layer Security
      - uses UTP instead of TCP
      - UDP is connectionless and therefore faster