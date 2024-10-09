#!/bin/bash

######################################
# Author: Prasad
# Date: 09/10/2024
#
# This script use to create SSL/TLS certificate
#
# Version : v1
######################################

DOMAIN="test.credenz.co.in"
EMAIL="prasadkhatake20@gmail.com"  

CERT_PATH="/etc/nginx/certs"
CERT_FULLCHAIN="$CERT_PATH/live/$DOMAIN/fullchain.pem"
CERT_PRIVKEY="$CERT_PATH/live/$DOMAIN/privkey.pem"

# Check if certificate already exists
if [ -f "$CERT_FULLCHAIN" ] && [ -f "$CERT_PRIVKEY" ]; then
    echo "SSL certificates already exist for $DOMAIN."
else
    echo "SSL certificates not found. Creating new certificates..."

    # Create SSL certificates using Certbot
    certbot certonly --standalone --non-interactive --agree-tos \
        --email $EMAIL -d $DOMAIN --config-dir /etc/nginx/certs --work-dir /etc/nginx/certs --logs-dir /etc/nginx/certs

    # Copy the certs to the right location
    cp /etc/nginx/certs/live/$DOMAIN/fullchain.pem /etc/nginx/certs/fullchain.pem
    cp /etc/nginx/certs/live/$DOMAIN/privkey.pem /etc/nginx/certs/privkey.pem

    echo "SSL certificates have been created and stored in /etc/nginx/certs"
fi

