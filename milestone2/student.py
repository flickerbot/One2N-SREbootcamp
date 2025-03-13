from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
import os
from dotenv import load_dotenv  # Import dotenv
from flask_migrate import Migrate
from sqlalchemy import create_engine, text


load_dotenv()

MYSQL_USER=os.getenv('MYSQL_USER')
MYSQL_PASSWORD=os.getenv('MYSQL_PASSWORD')
MYSQL_HOST=os.getenv('MYSQL_HOST')
MYSQL_PORT=os.getenv('MYSQL_PORT','3306')
MYSQL_DATABASE=os.getenv('MYSQL_DATABASE')


# Load environment variables from .env



engine_url = f"mysql+pymysql://{MYSQL_USER}:{MYSQL_PASSWORD}@{MYSQL_HOST}:{MYSQL_PORT}"

# Create the database if it doesn't exist
try:
    # Create engine without database
    engine = create_engine(engine_url)
    
    # Use text() to create a proper SQL expression
    with engine.connect() as connection:
        connection.execute(text(f"CREATE DATABASE IF NOT EXISTS {MYSQL_DATABASE}"))
        connection.commit()
    
    print(f"Database {MYSQL_DATABASE} created or already exists")
except Exception as e:
    print(f"Error creating database: {e}")


app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URL')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
print(f"Connected to database: {app.config['SQLALCHEMY_DATABASE_URI']}")

db = SQLAlchemy(app)
migrate = Migrate(app, db)

class Student(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    age = db.Column(db.Integer, nullable=False)
    grade = db.Column(db.String(10), nullable=False)

# Create DB Tables
with app.app_context():
    db.create_all()

# route for healthcheck of the API
@app.route('/healthcheck', methods=['GET'])
def healthcheck():
    return jsonify({"status": "ok"}), 200

# Adding a new student 
@app.route('/api/v1/students', methods=['POST'])
def add_student():
    data = request.get_json()
    if not data or not all(k in data for k in ('name', 'age', 'grade')):
        return jsonify({'error': 'Missing required fields'}), 400
    
    student = Student(name=data['name'], age=data['age'], grade=data['grade'])
    db.session.add(student)
    db.session.commit()
    return jsonify({'message': 'Student added successfully', 'student': {'id': student.id, 'name': student.name, 'age': student.age, 'grade': student.grade}}), 201

# fetching all the students 
@app.route('/api/v1/students', methods=['GET'])
def get_students():
    students = Student.query.all()
    return jsonify({'students': [{'id': s.id, 'name': s.name, 'age': s.age, 'grade': s.grade} for s in students]}), 200

# fetching particular student using ID 
@app.route('/api/v1/students/<int:id>', methods=['GET'])
def get_student(id):
    student = Student.query.get(id)
    if not student:
        return jsonify({'error': 'Student not found'}), 404
    return jsonify({'id': student.id, 'name': student.name, 'age': student.age, 'grade': student.grade}), 200

# Update student data 
@app.route('/api/v1/students/<int:id>', methods=['PUT'])
def update_student(id):
    data = request.get_json()
    student = Student.query.get(id)
    if not student:
        return jsonify({'error': 'Student not found'}), 404
    
    student.name = data.get('name', student.name)
    student.age = data.get('age', student.age)
    student.grade = data.get('grade', student.grade)
    db.session.commit()
    
    return jsonify({'message': 'Student updated successfully', 'student': {'id': student.id, 'name': student.name, 'age': student.age, 'grade': student.grade}}), 200

# Delete particular student 
@app.route('/api/v1/students/<int:id>', methods=['DELETE'])
def delete_student(id):
    student = Student.query.get(id)
    if not student:
        return jsonify({'error': 'Student not found'}), 404
    
    db.session.delete(student)
    db.session.commit()
    
    return jsonify({'message': 'Student deleted successfully'}), 200

if __name__ == '__main__':
    app.run(host=os.getenv('HOST_PORT'), port=os.getenv('APP_PORT'), debug=True)
