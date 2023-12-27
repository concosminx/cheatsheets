General stuff

```
sudo apt update
sudo apt upgrade
sudo apt install curl
sudo apt install wget
sudo apt install mc
```

Install Java(s)
```
sudo apt-cache search openjdk
sudo apt install openjdk-17-jdk
sudo apt install openjdk-21-jdk
echo "export JAVA_HOME=/usr/lib/jvm/java-1.17.0-openjdk-amd64" >> ~/.bashrc
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.bashrc
source ~/.bashrc
```

Install Intelij (via terminal)
```
sudo apt install vim apt-transport-https curl wget software-properties-common
sudo add-apt-repository ppa:mmk2410/intellij-idea -y
sudo apt install intellij-idea-community -y
```

Install Postman (via terminal)
```
sudo apt install snapd
sudo snap install postman
```

