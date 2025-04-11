#!/bin/sh

# Exit immediately if any command fails
set -e  


if [ "$RUN_MIGRATIONS" = "true" ] && [ "$IN_INIT" = "true" ]; then
    echo "Running database migrations..."
    while true; do
        flask db upgrade
        if [ $? -eq 0 ]; then
            echo "Database migrations completed successfully."
            break
        else
            echo "Migrations failed. Retrying in 10 seconds..."
            sleep 10
        fi
    done
     # Exit after migrations complete
    echo "Exiting init container after migrations."
    exit 0
fi


# Start Flask application
echo "Starting Flask API..."
exec flask run --host="${FLASK_HOST}" --port="${FLASK_PORT}"  
  #exec flask run --host=0.0.0.0 --port=5000
