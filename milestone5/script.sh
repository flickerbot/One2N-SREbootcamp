#!/bin/bash
set -e
set -x

install_make(){
echo "........ Installing make......"
sudo apt-get install -y make
}


install_docker(){
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "......Adding current user to docker group........."
sudo usermod -aG docker vagrant

echo "....... Enabling Docker service........."
sudo systemctl enable docker
sudo systemctl start docker

}


run_make_commands() {

 # Change to the directory containing the Makefile
  cd /app
  
  #setting up the env 
  make env

  # Run make deploy command
  make deploy
  
  ## Wait for services to fully start 
  sleep 10
  
  # Check status of services
  make status
  
  # Display service logs
  make logs
}


main(){
    echo "Starting provisioning process..."
   sudo apt-get update 
    install_make
    install_docker
    run_make_commands
}


main 