FROM python:alpine as baseimage
# Base stage: Uses the lightweight Alpine Linux with Python
# This is the build stage for dependencies only

# Create app-specific user with ID 10001 for security (non-root)
# -D creates a user without a password
RUN adduser -u 10001 -D flaskapp

# Create the application directory
RUN mkdir /app

# Copy only requirements file for dependency installation
COPY requirements.txt /app/

# Set the working directory
WORKDIR /app

# Switch to non-root user for pip installation 
USER flaskapp

# Install Python dependencies to user's home directory
# --user flag installs packages to ~/.local/
RUN pip install --user -r requirements.txt


FROM python:alpine
# Final stage: Creates a clean image with only necessary components
# Multi-stage build reduces final image size

# Recreate the same user with identical UID for consistency
RUN adduser -u 10001 -D flaskapp

# Set working directory for the application
WORKDIR /app

# Copy only the installed dependencies from the base image
# This keeps the final image small by excluding build tools
COPY --from=baseimage /home/flaskapp/.local /home/flaskapp/.local

# Copy application code and scripts
COPY student.py /app/
COPY migrations /app/migrations
COPY entrypoint.sh /app/
RUN chmod +x /app/entrypoint.sh

# Set appropriate ownership for all application files
RUN chown -R flaskapp:flaskapp /app

# Switch to non-root user for running the application (security best practice)
USER flaskapp

# Configure Flask environment variables
ENV FLASK_APP=student.py

# Add the user's local bin directory to PATH for accessing installed packages
ENV PATH=/home/flaskapp/.local/bin:$PATH

# Define the container's entry point script
ENTRYPOINT ["/app/entrypoint.sh"]