#!/bin/bash

# Install Docker
sudo apt-get update && sudo apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg-agent \
	software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
case $(uname -m) in
	x86_64)
		arch='amd64'
		;;
	aarch64)
		arch='arm64'
		;;
	*)
		echo "ERROR: arch not supported by this script"
		exit 1
		;;
esac
sudo add-apt-repository \
	"deb [arch=$arch] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update && sudo apt-get install -y \
	docker-ce docker-ce-cli containerd.io
sudo docker run --rm hello-world
sudo docker rmi hello-world:latest

# Setup so that Docker can be run without sudo
sudo usermod -aG docker `whoami`

# Install docker-compose
if ! which docker-compose > /dev/null; then
	sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
	sudo chmod +x /usr/local/bin/docker-compose
fi
