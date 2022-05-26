#!/bin/bash

# Apply database migrations
echo "Apply database migrations"
python manage.py migrate

#Create admin user
DJANGO_SUPERUSER_USERNAME=admin \
DJANGO_SUPERUSER_PASSWORD=admin \
DJANGO_SUPERUSER_EMAIL=admin@example.com \
python manage.py createsuperuser --noinput

# Start server
echo "Starting server"
python manage.py runserver 0.0.0.0:8000
