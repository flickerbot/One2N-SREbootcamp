# One2N-SREbootcamp

## Milestone 5 - Setting up REST API & its dependent services on bare metal


## Prerequisites

- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](https://www.vagrantup.com/downloads)

## Project Structure

```
├── Vagrantfile        # Vagrant configuration
├── script.sh          # Provisioning script
├── docker-compose.yml # Docker services configuration
├── Makefile           # Deployment commands
└── README.md          # This file
```


#### **1. Clone the repository and navigate to the project directory**

```bash
git clone https://github.com/flickerbot/One2N-SREbootcamp.git
cd One2N-SREbootcamp/milestone5

```


### 2. Create Vagrant VM

From the project root directory, run:

```bash
vagrant up
# this command will automatically download ubuntu22 image , install 
# and setup our application in a virtual machine based environment 

```


### Accessing the API

The API is accessible at `http://localhost:8080` on your host machine.

## Understanding the Components

### Vagrant

Vagrant is used to create a consistent and reproducible development environment. The `Vagrantfile` defines:
- Base VM image (Ubuntu 22.04)
- Resource allocation (2GB RAM, 2 CPUs)
- Port forwarding (8080 on guest to 8080 on host)
- Shared folder mapping (current directory to `/app` in VM)
- Provisioning script to set up dependencies

### Docker & Docker Compose

Docker is used to containerize the application and its dependencies. The setup includes:
- 2 API containers for 
- 1 Database container 
- 1 Nginx container for load balancing 


![architecture-image](https://www.notion.so/image/https%3A%2F%2Fprod-files-secure.s3.us-west-2.amazonaws.com%2F9ce3a364-243d-4bf8-803e-331bbc517340%2F41791756-404b-4773-a7b2-f4767095d272%2Fvagrant-deployment.png?table=block&id=f93e1a64-1cf8-4fc6-beab-1ae82d71857c&cache=v2)

### Nginx

Nginx serves as a load balancer, distributing requests between the two API containers.

### Makefile

The Makefile provides simple commands to manage the deployment:
- `make deploy`: Start all services
- `make status`: Check the status of all containers
- `make logs`: View the logs from all services



### 3. Cleaning Up

To stop and remove the VM:

```bash
vagrant halt   # Stop the VM
vagrant destroy  # Remove the VM
```


### Further Reading 
- [Vagrant Docs](https://developer.hashicorp.com/vagrant/docs)
- [Deploying Nginx using Docker](https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-docker)
- [How to use Nginx Docker image](https://www.docker.com/blog/how-to-use-the-official-nginx-docker-image)


```