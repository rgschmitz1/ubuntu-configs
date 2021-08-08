#!/bin/bash

# Install Docker
sudo apt-get update && sudo apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg-agent \
	software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
	"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
	$(lsb_release -cs) \
	stable"
sudo apt update && sudo apt install -y \
	docker-ce docker-ce-cli containerd.io
sudo docker run --rm hello-world
sudo docker rmi hello-world:latest

# Setup so that Docker can be run without sudo
sudo usermod -aG docker `whoami`
