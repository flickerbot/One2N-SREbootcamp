# One2N-SREbootcamp

## Student CRUD REST API

This is a REST API built using Python and Flask to manage student records. The API allows users to:

- Add a new student
- Retrieve all students
- Retrieve a student by ID
- Update student details
- Delete a student
- Check API health status


##  Setup Instructions

### **1. Clone the Repository**

```bash
git clone https://github.com/flickerbot/One2N-SREbootcamp.git
cd One2N-SREbootcamp
```
### **2. Create a Virtual Environment**
```
python -m venv namevenv
source namevenv/bin/activate   # macOS/Linux
namevenv\Scripts\activate      # Windows
```
### **2. Install Dependencies**
 
```
pip install -r requirements.txt

```
### **3. Set Up Environment Variables**
```
DATABASE_URL=sqlite:///students.db   
```


### **4. Start the API Server**

```
python student.py
```

### **5. Test API Endpoints

**Add a Student (POST)**

```
curl -X POST http://127.0.0.1:5000/api/v1/students \
     -H "Content-Type: application/json" \
     -d '{"name": "John Doe", "age": 20, "grade": "A"}'
```

**Get All Students (GET)**

```
curl -X GET http://127.0.0.1:5000/api/v1/students
```
