# Makefile for Student Management API

# Load environment variables from .env file
ifneq (,$(wildcard .env))
    include .env
    export
endif

# # Default values if not set in .env
# VENV ?= venv
# HOSTPORT ?= 0.0.0.0
# APP_PORT ?= 5000
# FLASK_APP ?= student.py
# PYTEST ?= pytest

# Phony targets ensure these commands always run
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  setup        - Install dependencies"
	@echo "  run          - Run the Flask application"
	@echo "  migrate      - Run database migrations"
	@echo "  create-migration - Create a new database migration"
	@echo "  test         - testing the api using unittest"
	@echo "  clean        - Clean up project files"



# Install dependencies
.PHONY: setup
setup:
	@echo "Installing dependencies..."
	pip install -r requirements.txt
	@echo "Dependencies installed successfully."

# Run the Flask application
.PHONY: run
run:
	@echo "Running application on ${HOSTPORT}:${APP_PORT}"
	flask -A ${FLASK_APP} run --host=${HOSTPORT} --port=${APP_PORT}


# Database Migrations
.PHONY: migrate
migrate:
	@echo "Running database migrations..."
	flask db upgrade

# Create a new migration
.PHONY: create-migration
create-migration:
	@read -p "Enter migration description: " desc; \
	flask db migrate -m "$$desc"

# Downgrade migration
.PHONY: downgrade
downgrade:
	@echo "reverting to previous database migrations..."
	flask db downgrade



#testing the API 
.PHONY: test
test:
	@echo "Running API tests..."
	python -m unittest test.py


.PHONY: lint
lint:
	@echo "Running linting ..."
	pylint student.py




# Clean up project files
.PHONY: clean
clean:
	@echo "Cleaning up..."
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	rm -rf *.log


# Full setup and run
.PHONY: all
all: clean setup migrate


# why is the purpose of the .PHONY https://stackoverflow.com/questions/2145590/what-is-the-purpose-of-phony-in-a-makefile