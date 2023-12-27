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

Install Visual Studio 
```
sudo apt install software-properties-common apt-transport-https wget -y
wget -O- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/vscode.gpg
echo deb [arch=amd64 signed-by=/usr/share/keyrings/vscode.gpg] https://packages.microsoft.com/repos/vscode stable main | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
sudo apt install code
```

- run `sudo apt remove code -y` to remove it
- or install with snap `sudo snap install code` and remove it `sudo snap remove code --purge`
