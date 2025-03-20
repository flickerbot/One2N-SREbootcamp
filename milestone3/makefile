# Variables
DOCKER_COMPOSE = docker-compose

.PHONY: all start-db check-db run-migrations run-api build-api clean help

# Default target: Run the API
all: run-api

# Start the database container
start-db:
	@echo " Starting MySQL database container..."
	@$(DOCKER_COMPOSE) up -d db
	@sleep 5  # Wait for the DB container to initialize
	@$(MAKE) check-db > /dev/null 2>&1  # Ensure the DB is ready before proceeding

# Check if DB is ready
check-db:
	@echo " Checking if MySQL is ready..."
	@until $(DOCKER_COMPOSE) exec -T db mysqladmin ping -h localhost --silent; do \
		echo "  Waiting for DB..."; \
		sleep 5; \
	done
	@echo "✅ MySQL is ready!"

# Run database migrations only if needed
run-migrations:
	@echo " Checking and running database migrations..."
	@$(DOCKER_COMPOSE) run --rm -e RUN_MODE=migrations api flask db upgrade
	@echo " Migrations completed."

# Build the API Docker image
build-api:
	@echo " Building API Docker image..."
	@$(DOCKER_COMPOSE) build api

# Start the API container
start-api:
	@echo " Starting API container..."
	@$(DOCKER_COMPOSE) up -d api
	@echo " API is now running at http://localhost:5000"

# Full process: Build API, Start DB, Run Migrations, Start API
run-api: build-api start-db run-migrations start-api

# Stop and remove all containers
clean:
	@echo " Stopping and removing all containers..."
	@$(DOCKER_COMPOSE) down -v
	@echo " All containers stopped and removed."

# Show available commands
help:
	@echo " Available commands:"
	@echo "  start-db        - Start the MySQL database container"
	@echo "  check-db        - Check if MySQL is ready"
	@echo "  run-migrations  - Run database migrations"
	@echo "  build-api       - Build the API Docker image"
	@echo "  run-api         - Start the API (includes DB, migrations, and build)"
	@echo "  clean           - Stop and remove all containers"
	@echo "  help            - Show this help message"
