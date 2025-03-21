# One2N-SREbootcamp

## Milestone3 - One-Click Local Development Setup

The purpose of this milestone is to streamline the local development setup for the API and its dependent services. By leveraging Docker Compose and Makefile, we aim to simplify the process of running the API with minimal manual intervention.


## Prerequisites 

### If you only want to run the API and its dependent services: 

- **Make** - Build automation tool used for running commands
- **Docker** - Container platform 
- **Docker-compose** 



### If you want to make changes in db schema and run migrations 

- **Python 3.8+**
- **Mysql 8.0.41**
- **pip** - Python package manager
- **Git** - Version control system to clone the repository
- **Make** - Build automation tool used for running commands
- **Docker** - Container platform 
- **curl** - Command-line tool for testing API endpoints (optional)


## Getting Started

#### **1. Clone the repository and navigate to the project directory**

```bash
git clone https://github.com/flickerbot/One2N-SREbootcamp.git
cd One2N-SREbootcamp/milestone3
```

#### **2. Set Up Environment Variables**

Create a `.env` file in the project root directory using `.env.example` as a reference. This is required for both setup options.


## **Setup Options**

You have two options for setting up the project:

### Option A: One-Click Setup (Recommended)

If you want to quickly set up the entire environment with a single command:

```bash
# Start everything (database, migrations, API)
make up IMAGE_TAG=1.0.0

# When finished, shut everything down
make down IMAGE_TAG=1.0.0
```

### **Option B: Step-by-Step Setup**

If you need to make schema changes or want more control over the setup process:

#### **1. Create a Virtual Environment**

```bash
python3 -m venv namevenv
source namevenv/bin/activate   # macOS/Linux
namevenv\Scripts\activate      # Windows
```

#### **2. Install Dependencies**

```bash
# installing dependencies specified in requirements file 
make setup
```

#### **3. Run Database Migrations**

Ensure your local database is running, then:

```bash
# Will run  migration on local db and updates the db schema 
make migrate
```

#### **4. Build the Docker Image**

```bash
# It will build the Docker container with the specified IMAGE_TAG
make build-api IMAGE_TAG=1.0.0
```

#### **5. Start the Database and API**

```bash
make start-db                    # Start the database first
make start-api IMAGE_TAG=1.0.0   # Start the API
```


#### **Cleanup Resources**

 
```bash
# To stop and remove all containers and volumes: 
make clean
```

 