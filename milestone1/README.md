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
cd One2N-SREbootcamp/milestone1
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
DATABASE_URL=mysql+pymysql://admin:password@localhost:3306/student_db
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


### Running Migrations 

To create a new migration after changing your models:
```bash
make create-migration
```

To apply pending migrations:
```bash
make migrate
```