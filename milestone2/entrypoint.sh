#!/bin/sh

# Exit immediately if any command fails
set -e  

# Run database migrations if the flag is set
if [ "$RUN_MIGRATIONS" = "true" ]; then
    echo "Running database migrations..."
    flask db upgrade
else
    echo "Skipping database migrations."
fi

# Start Flask application
echo "Starting Flask application..."
exec flask run --host="${FLASK_HOST}" --port="${FLASK_PORT}"
