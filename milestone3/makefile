# Variables
DOCKER_COMPOSE = docker-compose



.PHONY: setup migrate run-api build-api start-db clean 

# To run the migration on your local machine for this you need to have python and db setup at local 

setup:
	@echo "Installing dependencies..."
	pip install -r requirements.txt

#running migration at local 
.PHONY: migrate
migrate:
	@echo "Running database migrations..."
	flask db upgrade             

# Build the API Docker image
build-api:
	@echo "Building API Docker image with tag: $(IMAGE_TAG)..."
	@$(DOCKER_COMPOSE) build --build-arg IMAGE_TAG=$(IMAGE_TAG) api



# Start the database container individually 
start-db: 
	@echo " Starting MySQL database container..."
	@$(DOCKER_COMPOSE) up -d db
	@sleep 10  # Wait for the DB container to initialize
	


# Start the API container individually 
start-api:
	@echo " Starting API container..."
	@$(DOCKER_COMPOSE) up -d api
	@echo " API is now running at http://localhost:5000"	




up:
	@echo " Starting API container..."
	@$(DOCKER_COMPOSE) up --build -d 

down:
	@echo " Stopping API container..."
	@$(DOCKER_COMPOSE) down


# Stop and remove all containers
clean:
	@echo " Stopping and removing all containers..."
	@$(DOCKER_COMPOSE) down -v
	@echo " All containers stopped and removed."

