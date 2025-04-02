# One2N-SREbootcamp

## Milestone4 - Setup a CI pipeline

Outcome of this milestone is to setup githib workflows using self hosted runner on local machine 

## Prerequisites 

- **Python 3.8+**
- **Mysql 8.0.41**
- **Make** - Build automation tool used for running commands
- **Docker** - Container platform 
- **pip** - Python package manager
- **Git** - Version control system to clone the repository

## Getting Started

#### **1. Clone the repository and navigate to the project directory**

```bash
git clone https://github.com/flickerbot/One2N-SREbootcamp.git
cd One2N-SREbootcamp/milestone4
```


#### **2. Setting up the github self hosted-runner**

On GitHub, navigate to the main page of the repository.

- Under your repository name, click
Settings. If you cannot see the "Settings" tab, select the dropdown menu, then click Settings.

- In the left sidebar, click Actions, then click Runners.

- Click New self-hosted runner.

- Select the operating system image and architecture of your self-hosted runner machine

- You will see instructions showing you how to download the runner application and install it on your self-hosted runner machine.

- Open a shell on your self-hosted runner machine and run each shell command in the order shown.


Refer this article for more details 

```bash
https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/adding-self-hosted-runners

```


#### **3. Setting up github runner as a service in host machine**

For Linux systems that use systemd, you can use the svc.sh script that is created after successfully adding the runner to install and manage using the application as a service.

On the runner machine, open a shell in the directory where you installed the self-hosted runner application. Use the commands below to install and manage the self-hosted runner service.

- Install the service with the following command:
```bash
    sudo ./svc.sh install
```

- Starting the service

Start the service with the following command:
```bash
sudo ./svc.sh start
```
- Checking the status of the service

Check the status of the service with the following command:

```bash
sudo ./svc.sh status
```


#### **4. Add Docker secrets in Github**

- Go to your GitHub repository.

- Navigate to Settings → Secrets → Actions (on the left sidebar).

- Click on the New repository secret button.

- Name the secret DOCKER_USERNAME and add your Docker username as the value.

- Name the secret DOCKER_PASSWORD and add your Docker password as the value.

#### Now whenever any changes will be made in student.py code the pipeline will be triggered automatically 