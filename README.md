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
- **pip** - Python package manager
- **Git** - Version control system to clone the repository
- **Make** - Build automation tool used for running commands
- **Docker** - Container platform (required only for Docker setup)
- **curl** - Command-line tool for testing API endpoints (optional)




## Setup Instructions

### **Option 1: Local Setup**

#### **1. Clone the Repository**

```bash
git clone https://github.com/flickerbot/One2N-SREbootcamp.git
cd One2N-SREbootcamp
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
DATABASE_URL=sqlite:///students.db
HOSTPORT=0.0.0.0
APP_PORT=5000
FLASK_APP=student.py
```

#### **5. Start the API Server**
```bash
make run
```
or
```bash
python student.py
```

### **Option 2: Docker Setup**

#### **1. Clone the Repository**
```bash
git clone https://github.com/flickerbot/One2N-SREbootcamp.git
cd One2N-SREbootcamp
```

#### **2. Create a .env File**
Create a `.env` file in the project root with the following contents:
```
DATABASE_URL=sqlite:///students.db
HOST_PORT=0.0.0.0
APP_PORT=5000
FLASK_APP=student.py
# Set to "true" only when migrations are needed
RUN_MIGRATIONS=false
```

#### **3. Build the Docker Image**
```bash
make docker-build IMAGE_TAG=1.0.0
```
or
```bash
docker build -t student:1.0.0 .
```

#### **4. Run the Docker Container**

**Without Migrations (Faster startup, recommended for regular use):**
```bash
make docker-run IMAGE_TAG=1.0.0
```
or
```bash
docker run -it \
    --env-file .env \
    -e FLASK_HOST=0.0.0.0 \
    -e FLASK_PORT=5000 \
    -p 5000:5000 \
    student:1.0.0
```

**With Migrations (Only needed for initial setup or schema changes):**
```bash
make docker-run IMAGE_TAG=1.0.0 RUN_MIGRATIONS=true
```
or
```bash
docker run -it \
    --env-file .env \
    -e FLASK_HOST=0.0.0.0 \
    -e FLASK_PORT=5000 \
    -e RUN_MIGRATIONS=true \
    -p 5000:5000 \
    student:1.0.0
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

For regular operation, you can skip migrations to improve container startup time.

### Running Migrations Manually

To create a new migration after changing your models:
```bash
make create-migration
```

To apply pending migrations:
```bash
make migrate
```
