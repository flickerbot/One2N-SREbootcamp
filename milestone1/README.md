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
python3 -m venv namevenv
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

### Example Model Change

If you want to add a new column email to the Student model, modify the model in student.py
```bash
class Student(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    age = db.Column(db.Integer, nullable=False)
    grade = db.Column(db.String(10), nullable=False)
    email = db.Column(db.String(100), unique=True, nullable=False)  # New column
```

Then, create and apply the migration:

```bash
make create-migration
make migrate
```

If you need to revert to the previous database schema

```bash
make downgrade
```




#### **6. Start the API Server**

```bash
make run
```
#### **7. To run unitest**
```bash
make test
```
#### **8. To lint the code**
```bash
make lint
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
