#!/bin/sh

# Exit immediately if any command fails
set -e  


#flask migartion next step will only be executed when migrations are complete 
if [ "$RUN_MIGRATIONS" = "true" ]; then
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
else
    echo "Skipping database migrations."
fi

# Start Flask application
echo "Starting Flask API..."
exec flask run --host="${FLASK_HOST}" --port="${FLASK_PORT}"  
  #exec flask run --host=0.0.0.0 --port=5000
