# One2N-SREbootcamp
This repository contains a Student Management REST API developed as part of the One2N SRE Bootcamp, 
implementing progressive SRE principles through multiple milestones.

## Milestones Overview

### Milestone 1: Simple REST API
- Python Flask REST API for student management (CRUD operations)
- Makefile to build and run the REST API locally.
- Ability to run DB schema migrations to create the student table.
- Configured via environment variables
- Includes API versioning and healthcheck endpoint
- Postman collection for the APIs.

### Milestone 2: Docker Containerization
- Multi-stage Dockerfile implementation
- Runtime environment variable injection
- Makefile to build and run Docker Image 
- Exposing Docker-container using host network and integration with db on local 

### Milestone 3: One-Click Development Setup
- One-click deployment setup using makefile and Docker-compose 
- Docker Compose for API and dependencies
- Coordinated container orchestration
- Automated database migration handling

## Repository Structure

```
One2N-SREbootcamp/
├── milestone1/       # Simple REST API
├── milestone2/       # Containerized API
├── milestone3/       # One-click dev setup
└── README.md         # Project documentation
```

Each milestone folder contains its own README with specific setup instructions and requirements.

## Further Reading

### Milestone 1
* [The Twelve-Factor App](https://12factor.net/)
* [Readme Driven Development](https://tom.preston-werner.com/2010/08/23/readme-driven-development.html)

### Milestone 2
* [Dockerfile Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
* [Advanced Dockerfile](https://docs.docker.com/engine/reference/builder/)
* [Hadolint](https://github.com/hadolint/hadolint)
* [Semantic Versioning](https://semver.org/)

### Milestone 3
* [Docker Compose Documentation](https://docs.docker.com/compose/)
* [GNU Make Documentation](https://www.gnu.org/software/make/manual/make.html)