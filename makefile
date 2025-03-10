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
	@echo "  test         - Run tests"
	@echo "  migrate      - Run database migrations"
	@echo "  create-migration - Create a new database migration"
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


#docker_setup
.PHONY: docker-build
docker-build:
	@echo "Building Docker image $(IMAGE_TAG)..."
	docker build -t student:$(IMAGE_TAG) .
	@echo "Docker image built successfully."

#docker_setup
.PHONY: docker-run
docker-run:
	docker run -it \
	    --env-file .env \
		-e FLASK_HOST=$(HOST_PORT) \
		-e FLASK_PORT=$(APP_PORT) \
		-p $(APP_PORT):$(APP_PORT) \
		student:$(IMAGE_TAG)
	@echo "Docker container started. Access the API at http://localhost:$(APP_PORT)"



# why is the purpose of the .PHONY https://stackoverflow.com/questions/2145590/what-is-the-purpose-of-phony-in-a-makefile