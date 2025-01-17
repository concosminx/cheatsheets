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

### How To Import Other Users’ Public Keys
```shell
gpg --import name_of_pub_key_file
```

## How To Verify and Sign Keys
- Verify the Other Person’s Identity - get the fingerprint of a public key by typing `gpg --fingerprint your_email@address.com`
- Sign Their Key - `gpg --sign-key email@example.com`
- Export signed key - `gpg --output ~/signed.key --export --armor email@example.com`
- Import signed key - `gpg --import ~/signed.key`

### Upload to a key server
```shell
gpg --send-keys --keyserver pgp.mit.edu key_id
```



## Encrypt and Decrypt Messages with GPG

### Encrypt Messages
```shell
gpg --output doc.gpg --encrypt --recipient x@example.org doc.txt
```

### Decrypt Messages
```shell
gpg --output doc --decrypt doc.gpg
```

### Update the key information 
- `gpg --refresh-keys`
- `gpg --keyserver key_server --refresh-keys`

--- 

Extras
- [https://gpg4win.de/about.html](https://gpg4win.de/about.html)
- [https://www.digitalocean.com/community/tutorials/how-to-use-gpg-to-encrypt-and-sign-messages#how-to-import-other-users-public-keys](https://www.digitalocean.com/community/tutorials/how-to-use-gpg-to-encrypt-and-sign-messages#how-to-import-other-users-public-keys)
- [https://www.gnupg.org/gph/en/manual/c14.html](https://www.gnupg.org/gph/en/manual/c14.html)
