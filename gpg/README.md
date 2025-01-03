### Install GnuPG on Debian / Ubuntu

```shell
sudo apt-get install gnupg

# Fix your gnupg home directory's permissions.
chmod 0700 ~/.gnupg/
```

### List your GPG keys
```shell
gpg --list-keys
```

### Generate a new GPG key pair
```shell
gpg --full-generate-key
```

### Edit your GPG key’s expiration date
```shell
gpg --edit-key akey@example.com
```

[edit ](https://www.gnupg.org/gph/en/manual/r899.html)

### Change your GPG key’s passphrase
```shell
gpg --passwd akey@example.com
```

### Generate and import a GPG revoke certificate
```shell
# You can skip this step if you're using GnuPG version 2.1 or above.
gpg --output revoke-akeyexample.asc --gen-revoke akey@example.com

# Revoke the GPG key.
gpg --import revoke-akeyexample.asc
```

### Export your GPG public key
```shell
# Echo your public key to stdout.
gpg --export --armor akey@example.com

# Write your public key to a file.
gpg --export --armor --output akeyexample.gpg.pub akey@example.com
```

### Backup and restore your GPG key pair
```shell
gpg --export-secret-keys --armor --output akeyexample.gpg akey@example.com
```



