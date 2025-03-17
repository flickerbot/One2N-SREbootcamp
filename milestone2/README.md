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
make setup
```

#### **4. Set Up Environment Variables**

Create a `.env` file in the project root, you can refer the `.env.example` file for reference:

#### **5 Database Migrations**

This API uses Flask-Migrate to handle database schema changes. Migrations help track and apply database changes consistently across different environments.

### When to Run Migrations

You only need to run migrations in these scenarios:

1. When setting up the application for the first time
2. After changing database models (schema changes)
3. When deploying to a new environment

### Running Migrations

To apply pending migrations:

```bash
make migrate
```

To create a new migration after changing your models:

```bash
make create-migration
```

#### **6. Start the API Server**

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
Create a `.env` file in the project root, you can refer the `.env.example` file for reference:

#### **3. Build the Docker Image**
```bash
make docker-build IMAGE_TAG=1.0.0
```

#### **4. Run the Docker Container**

**With Migrations (Only needed for initial setup or schema changes):**

```bash
make docker-run IMAGE_TAG=1.0.0 RUN_MIGRATIONS=true NETWORK_MODE=host
```

#### OR if we want to inject environment variable at runtime we can use this command, if not specified they are passed form .env file 

```bash
 make docker-run IMAGE_TAG=1.0.0 HOST=0.0.0.0 PORT=5000 RUN_MIGRATIONS=true NETWORK_MODE=host
```


**Without Migrations (Faster startup, recommended for regular use):**
```bash
make docker-run IMAGE_TAG=1.0.0 NETWORK_MODE=host 
```

#### OR 

```bash
make docker-run IMAGE_TAG=1.0.0 HOST=0.0.0.0 PORT=5000 NETWORK_MODE=host

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

## Postman Collection for API Testing

To use Postman collection to easily test all API endpoints without using curl .

###  How to Import in Postman:

1. Open **Postman** application.
2. Go to the **"Collections"** tab.
3. Click on the **"Import"** button.
4. Select **"Upload Files"**.
5. Browse to `Postman-API-Collection.json` and select it.
6. Click **"Import"** to add the collection.
 


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




 