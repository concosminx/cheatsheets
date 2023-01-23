# Table of contents

- [Table of contents](#table-of-contents)
- [Install Docker](#install-docker)
  - [preview script steps before running](#preview-script-steps-before-running)
  - [run the script](#run-the-script)
- [Quick Setup: Java+Git+Gradle](#quick-setup-javagitgradle)
  - [Java JDK](#java-jdk)
  - [Git](#git)
  - [Gradle](#gradle)
- [Enable SSH with root (not the greatest idea)](#enable-ssh-with-root-not-the-greatest-idea)

---

# Install Docker

## preview script steps before running

```shell
curl -fsSL https://get.docker.com -o get-docker.sh
DRY_RUN=1 sudo sh ./get-docker.sh
```

## run the script
```shell
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

Check [documentation](https://docs.docker.com/engine/install/ubuntu/)

# Quick Setup: Java+Git+Gradle

## Java JDK
- search the available packages `apt-cache search openjdk-17-jdk` 
- install Java JDK `apt install openjdk-17-jdk -y`
- check the java installed version `java -version`
- if multiple versions of java are available use `update-alternatives --config java`
  
## Git
- run `apt install git -y`
- generate a new ssh key `ssh-keygen -t ed25519 -C "your_email@example.com"` and add the generated key to ssh agent `ssh-add ~/.ssh/id_ed25519`
- configure the public key in github `cat ~/.ssh/id_ed25519.pub` 
- configure git: `git config --global user.email "you@example.com"` and `git config --global user.name "Your Name"`

## Gradle
- install [sdkman](https://sdkman.io/install) with `curl -s "https://get.sdkman.io" | bash`
- open a new terminal or enter `source "$HOME/.sdkman/bin/sdkman-init.sh"`
- install the gradle version `sdk install gradle 7.6`
- check the gradle instalation `gradle --version`

# Enable SSH with root (not the greatest idea)
- edit sshd config `sudo nano /etc/ssh/sshd_config`
- manualy modify from `#PermitRootLogin prohibit-password` to `PermitRootLogin yes`
- or use `sed` command `sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config`
- restart the ssh service `sudo systemctl restart ssh`
- set the password for root `sudo passwd` (by default the root password is not set)