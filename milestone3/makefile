# Variables
DOCKER_COMPOSE = docker-compose

# Define all phony targets (targets that don't represent files)
.PHONY: setup migrate run-api build-api start-db clean 

# Setup local development environment with required Python packages
# Use this when working on the codebase locally without Docker
setup:
	@echo "Installing dependencies..."
	pip install -r requirements.txt

# Run database migrations on local machine
# Requires local Python and database setup
.PHONY: migrate
migrate:
	@echo "Running database migrations..."
	flask db upgrade             

# Build the API Docker image with specified tag
# Usage: make build-api IMAGE_TAG=1.0.0
build-api:
	@echo "Building API Docker image with tag: $(IMAGE_TAG)..."
	@$(DOCKER_COMPOSE) build --build-arg IMAGE_TAG=$(IMAGE_TAG) api

# Start only the database container
# Useful for testing against the database while running API locally
start-db: 
	@echo " Starting MySQL database container..."
	@$(DOCKER_COMPOSE) up -d db
	@sleep 10  # Wait for the DB container to initialize properly
	
# Start only the API container
# Assumes database is already running or configured elsewhere
start-api:
	@echo " Starting API container..."
	@$(DOCKER_COMPOSE) up -d api
	@echo " API is now running at http://localhost:5000"	

# Start the entire application stack
# Builds containers if needed and runs them in detached mode
up:
	@echo " Starting API container..."
	@$(DOCKER_COMPOSE) up --build -d 

# Stop all containers but preserve volumes
down:
	@echo " Stopping API container..."
	@$(DOCKER_COMPOSE) down

# Full cleanup - stop containers and remove volumes
# Use this to completely reset the environment
clean:
	@echo " Stopping and removing all containers..."
	@$(DOCKER_COMPOSE) down -v
	@echo " All containers stopped and removed."