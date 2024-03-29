#!/bin/bash

which docker > /dev/null && exit 0

echo "Installing docker"

sudo apt-get update && sudo apt-get install -y \
	ca-certificates \
	curl \
	gnupg \
	lsb-release || exit $?

# Add Docker’s official GPG key
sudo mkdir -p /etc/apt/keyrings && \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Setup the repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install docker-ce and docker-compose
sudo apt-get update && sudo apt-get install -y \
	docker-ce docker-ce-cli containerd.io docker-compose-plugin || exit $?

# Verify docker is working
sudo docker run --rm hello-world || exit $?
sudo docker rmi hello-world:latest

# Setup so that Docker can be run without sudo
sudo usermod -aG docker $USER
exit $?
