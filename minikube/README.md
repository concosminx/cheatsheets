# MiniKube Setup 

## Install docker: 

- use https://docs.docker.com/engine/install/ubuntu/

## Apply updates


```bash
sudo apt update -y
sudo apt upgrade -y
```

- reboot your system

```bash
sudo reboot
```

## Install Minikube dependencies

```bash
sudo apt install -y curl wget apt-transport-https
```

## Download Minikube Binary

- download latest minikube binary

```bash
wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
```

- copy it to the path /usr/local/bin and set the executable permissions on it

```bash
sudo cp minikube-linux-amd64 /usr/local/bin/minikube
sudo chmod +x /usr/local/bin/minikube
```

- verify the minikube version

```bash
minikube version
```

## Install Kubectl utility

- download latest version of kubectl

```bash
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
```

- set the executable permissions on kubectl binary and move it to the path /usr/local/bin

```bash
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
```

- verify the kubectl version

```bash
kubectl version -o yaml
```

## Start minikube

- add your user to the docker group; start the minikube with the docker driver

```bash
sudo usermod -aG docker $USER && newgrp docker
minikube start --driver=docker
```

- or start minikube with customize resources

```bash
minikube start --addons=ingress --cpus=2 --cni=flannel --install-addons=true --kubernetes-version=stable --memory=6g
```

- check the status 

```bash
minikube status
kubectl cluster-info
kubectl get nodes
```

## Managing Addons on minikube

- list

```bash
minikube addons list
```

- if you wish to enable any addons run the below minikube command

```bash
minikube addons enable <addon-name>
```

- enable and access kubernetes dashboard

```bash
minikube dashboard
```

## Verify Minikube Installation

- install nginx

```bash
kubectl create deployment my-nginx --image=nginx
```

- verify deployment status
```bash
kubectl get deployments.apps my-nginx
kubectl get pods
```

- expose the deployment using following command

```bash 
kubectl expose deployment my-nginx --name=my-nginx-svc --type=NodePort --port=80
kubectl get svc my-nginx-svc
```

- get your service url

```bash
minikube service my-nginx-svc --url
```

## Managing Minikube Cluster

- stop `minikube stop`
- delete `minikube delete`
- start `minikube start`
- configure and start 

```bash
minikube config set cpus 4
minikube config set memory 8192
minikube delete
minikube start
```






