# One2N-SREbootcamp

## Student CRUD REST API

This is a REST API built using Python and Flask to manage student records. The API allows users to:

- Add a new student
- Retrieve all students
- Retrieve a student by ID
- Update student details
- Delete a student
- Check API health status


##Prerequisites

- **Python 3.8+** 
- **Mysql 8.0.41**
- **pip** - Python package manager
- **Git** - Version control system to clone the repository
- **Make** - Build automation tool used for running commands
- **Docker** - Container platform (required only for Docker setup)
- **curl** - Command-line tool for testing API endpoints (optional)




## Setup Instructions

### ** Local Setup**

#### **1. Clone the Repository**

```bash
git clone https://github.com/flickerbot/One2N-SREbootcamp.git
cd One2N-SREbootcamp/milestone2
```

#### **2. Create a Virtual Environment**
```bash
python -m venv namevenv
source namevenv/bin/activate   # macOS/Linux
namevenv\Scripts\activate      # Windows
```

#### **3. Install Dependencies**
```bash
pip install -r requirements.txt
```

#### **4. Set Up Environment Variables**
Create a `.env` file in the project root with the following contents:
```
DATABASE_URL=mysql+pymysql://admin:password@localhost:3306/student_db  #replace the admin:password with the respective user and password in mysql. To use same user and password refrer to end of this readme.
HOSTPORT=0.0.0.0
APP_PORT=5000
FLASK_APP=student.py
MYSQL_USER=admin
MYSQL_PASSWORD=password
MYSQL_HOST=localhost
MYSQL_PORT=3306
MYSQL_DATABASE=student_db

```

#### **5. Start the API Server**
```bash
make run
```


### ** Docker Setup**

#### **1. Clone the Repository**
```bash
git clone https://github.com/flickerbot/One2N-SREbootcamp.git
cd One2N-SREbootcamp/milestone2
```

#### **2. Create a .env File**
Create a `.env` file in the project root with the following contents:
```
DATABASE_URL=mysql+pymysql://admin:password@localhost:3306/student_db    
-- pass correct user and password at palce of admin:password. To create new user admin refer to end of this document 
HOSTPORT=0.0.0.0
APP_PORT=5000
FLASK_APP=student.py
RUN_MIGRATIONS=false
MYSQL_USER=admin
MYSQL_PASSWORD=password
MYSQL_HOST=localhost
MYSQL_PORT=3306
MYSQL_DATABASE=student_db

```

#### **3. Build the Docker Image**
```bash
make docker-build IMAGE_TAG=1.0.0
```

#### **4. Run the Docker Container**

**Without Migrations (Faster startup, recommended for regular use):**
```bash
make docker-run IMAGE_TAG=1.0.0
```

#### if we want to inject environment variable at runtime we can use this command, if not specified they are passed form .env file 

```bash
make docker-run IMAGE_TAG=1.0.0 HOST=0.0.0.0 PORT=4000 
```


**With Migrations (Only needed for initial setup or schema changes):**
```bash
make docker-run IMAGE_TAG=1.0.0 RUN_MIGRATIONS=true
```
#### OR 

```bash
 make docker-run IMAGE_TAG=1.0.0 HOST=0.0.0.0 PORT=4000 RUN_MIGRATIONS=true
```



## Testing API Endpoints

### **Add a Student (POST)**
```bash
curl -X POST http://127.0.0.1:5000/api/v1/students \
    -H "Content-Type: application/json" \
    -d '{"name": "John Doe", "age": 20, "grade": "A"}'
```

### **Get All Students (GET)**
```bash
curl -X GET http://127.0.0.1:5000/api/v1/students
```

### **Get a Student by ID (GET)**
```bash
curl -X GET http://127.0.0.1:5000/api/v1/students/1
```

### **Update a Student (PUT)**
```bash
curl -X PUT http://127.0.0.1:5000/api/v1/students/1 \
    -H "Content-Type: application/json" \
    -d '{"name": "John Updated", "age": 21, "grade": "A+"}'
```

### **Delete a Student (DELETE)**
```bash
curl -X DELETE http://127.0.0.1:5000/api/v1/students/1
```

### **Health Check**
```bash
curl -X GET http://127.0.0.1:5000/healthcheck
```

## Database Migrations

This API uses Flask-Migrate to handle database schema changes. Migrations help track and apply database changes consistently across different environments.

### When to Run Migrations

You only need to run migrations in these scenarios:
1. When setting up the application for the first time
2. After changing database models (schema changes)
3. When deploying to a new environment


### Running Migrations Manually

To create a new migration after changing your models:
```bash
make create-migration
```

To apply pending migrations:
```bash
make migrate
```

### Creating user admin in mysql 

```bash

-- Log in as root or a user with admin privileges:
mysql -u root -p

-- Create user (replace 'password' with your actual password):
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'password';

-- Grant all privileges on student_db:
GRANT ALL PRIVILEGES ON student_db.* TO 'admin'@'localhost';

-- Flush privileges to apply changes:
FLUSH PRIVILEGES;

```