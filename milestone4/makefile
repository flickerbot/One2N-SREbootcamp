# Variables
VENV_NAME := namevenv
PYTHON := python3
PIP := $(VENV_NAME)/bin/pip
PYTHON_VENV := $(VENV_NAME)/bin/python
LINT := $(VENV_NAME)/bin/pylint
PYTEST := $(VENV_NAME)/bin/pytest
DOCKER_REPO := flickerbot/student


# Define all phony targets (targets that don't represent files)
.PHONY: docker-build test lint


# Create virtual environment
$(VENV_NAME):
	$(PYTHON) -m venv $(VENV_NAME)


# Setup local development environment with required Python packages, 
#we are setting up the venv then we are installing all the dependencies 

setup:$(VENV_NAME)
	@echo "Installing dependencies..."
	$(PIP) install -r requirements.txt
	
# Perform linting using pylint
lint:
	@echo "Running linting..."
	$(LINT) --disable=R0903 student.py || true

# Run tests using unittest
test:
	@echo "Running tests..."
	$(PYTHON_VENV) -m unittest test.py

env:
	cp .env.example .env;

docker-build:
	@echo "Building and pushing Docker image with tag: $(DOCKER_TAG)"
	docker build -t $(DOCKER_REPO):$(DOCKER_TAG) .
	docker push $(DOCKER_REPO):$(DOCKER_TAG)

