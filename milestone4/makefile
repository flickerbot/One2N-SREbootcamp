
# Define all phony targets (targets that don't represent files)
.PHONY: docker-build test lint

# Setup local development environment with required Python packages
# Use this when working on the codebase locally without Docker
setup:
	@echo "Installing dependencies..."
	pip install -r requirements.txt
       

# Build the API Docker image with specified tag
# Usage: make build-api IMAGE_TAG=1.0.0

docker-build:
	@echo "Building Docker image $(IMAGE_TAG)..."
	docker build -t student:$(IMAGE_TAG) .
	@echo "Docker image built successfully."

test:
    @echo "Running tests"
	python -m unittest test.py

lint:
	@echo "Running linting ..."
	pylint student.py
