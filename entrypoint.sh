#!/bin/sh
# Run database migrations
echo "Running database migrations..."
#flask db migrate
#flask db upgrade

# Start Flask application
echo "Starting Flask application..."
flask -A student.py run --host=${FLASK_HOST} --port=${FLASK_PORT}