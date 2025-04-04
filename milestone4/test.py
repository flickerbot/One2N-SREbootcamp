import unittest
import json
import os
from dotenv import load_dotenv
import sys
import student  # Import your Flask app module

# Load environment variables
load_dotenv()

class TestStudentAPI(unittest.TestCase):
    """Test cases for Student API endpoints using Flask's test client"""
    
    def setUp(self):
        """Setup test client and data"""
        student.app.config['TESTING'] = True
        self.app = student.app.test_client()
        self.test_student = {
            "name": "Test Student",
            "age": 20,
            "grade": "A"
        }
        self.updated_student = {
            "name": "Updated Student",
            "age": 21,
            "grade": "A+"
            
        }
        # Student ID to be used in tests that need an existing student
        self.student_id = None

    def test_a_healthcheck(self):
        """Test the healthcheck endpoint"""
        response = self.app.get('/healthcheck')
        self.assertEqual(response.status_code, 200)
        data = json.loads(response.data)
        self.assertEqual(data["status"], "healthy")

    def test_b_add_student(self):
        """Test adding a new student"""
        response = self.app.post(
            '/api/v1/students',
            data=json.dumps(self.test_student),
            content_type='application/json'
        )
        self.assertEqual(response.status_code, 201)
        data = json.loads(response.data)
        self.assertEqual(data["message"], "Student added successfully")
        self.assertEqual(data["student"]["name"], self.test_student["name"])
        self.assertEqual(data["student"]["age"], self.test_student["age"])
        self.assertEqual(data["student"]["grade"], self.test_student["grade"])
        
        # Save student ID for use in other tests
        self.student_id = data["student"]["id"]

    def test_c_get_all_students(self):
        """Test getting all students"""
        response = self.app.get('/api/v1/students')
        self.assertEqual(response.status_code, 200)
        data = json.loads(response.data)
        self.assertIn("students", data)
        self.assertIsInstance(data["students"], list)

    def test_d_get_student_by_id(self):
        """Test getting a specific student by ID"""
        # First add a student if ID isn't set
        if self.student_id is None:
            self.test_b_add_student()
            
        response = self.app.get(f'/api/v1/students/{self.student_id}')
        self.assertEqual(response.status_code, 200)
        data = json.loads(response.data)
        self.assertEqual(data["name"], self.test_student["name"])
        self.assertEqual(data["age"], self.test_student["age"])
        self.assertEqual(data["grade"], self.test_student["grade"])

    def test_e_update_student(self):
        """Test updating a student"""
        # First add a student if ID isn't set
        if self.student_id is None:
            self.test_b_add_student()
            
        response = self.app.put(
            f'/api/v1/students/{self.student_id}',
            data=json.dumps(self.updated_student),
            content_type='application/json'
        )
        self.assertEqual(response.status_code, 200)
        data = json.loads(response.data)
        self.assertEqual(data["message"], "Student updated successfully")
        self.assertEqual(data["student"]["name"], self.updated_student["name"])
        self.assertEqual(data["student"]["age"], self.updated_student["age"])
        self.assertEqual(data["student"]["grade"], self.updated_student["grade"])

    def test_f_delete_student(self):
        """Test deleting a student"""
        # First add a student if ID isn't set
        if self.student_id is None:
            self.test_b_add_student()
            
        response = self.app.delete(f'/api/v1/students/{self.student_id}')
        self.assertEqual(response.status_code, 200)
        data = json.loads(response.data)
        self.assertEqual(data["message"], "Student deleted successfully")
        
        # Verify student is deleted
        response = self.app.get(f'/api/v1/students/{self.student_id}')
        self.assertEqual(response.status_code, 404)

    def test_g_nonexistent_student(self):
        """Test getting a nonexistent student"""
        response = self.app.get('/api/v1/students/99999')
        self.assertEqual(response.status_code, 404)
        data = json.loads(response.data)
        self.assertEqual(data["error"], "Student not found")

    def test_h_invalid_student_data(self):
        """Test adding a student with invalid data"""
        invalid_data = {"name": "Invalid Student"}  # Missing age and grade
        response = self.app.post(
            '/api/v1/students',
            data=json.dumps(invalid_data),
            content_type='application/json'
        )
        self.assertEqual(response.status_code, 400)
        data = json.loads(response.data)
        self.assertEqual(data["error"], "Missing required fields")

if __name__ == "__main__":
    unittest.main()