#!/bin/sh
set -e
# Wait for PostgreSQL to be ready
apk add postgresql-client || true  # Install pg_isready if not present
until pg_isready -h db -U postgres; do
  echo "Waiting for PostgreSQL..."
  sleep 1
done
flask db upgrade
gunicorn --bind 0.0.0.0:5000 -w 2 -t 2 --worker-class gthread --timeout 600 main:app
