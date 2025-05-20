#!/bin/bash

# Create nginx directory structure if it doesn't exist
mkdir -p nginx/ssl

# Generate self-signed certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout nginx/ssl/nginx.key -out nginx/ssl/nginx.crt \
  -subj "/C=VN/ST=State/L=City/O=Organization/CN=localhost"

# Set proper permissions
chmod 644 nginx/ssl/nginx.crt
chmod 600 nginx/ssl/nginx.key

echo "Self-signed certificate created successfully!"
echo "To start the application, run: docker-compose up -d" 