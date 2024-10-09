#!/bin/bash

######################################
# Author: Prasad
# Date: 09/10/2024
#
# This script is used to create SSL/TLS certificates
#
# Version: v1
######################################

DOMAIN="test.credenz.co.in"
EMAIL="prasadkhatake20@gmail.com"  

CERT_PATH="/etc/nginx/certs"
CERT_FULLCHAIN="$CERT_PATH/fullchain.pem"
CERT_PRIVKEY="$CERT_PATH/privkey.pem"

# Check if the certificate already exists
if [ -f "$CERT_FULLCHAIN" ] && [ -f "$CERT_PRIVKEY" ]; then
    echo "SSL certificates already exist for $DOMAIN."
else
    echo "SSL certificates not found. Creating new certificates..."

    # Create SSL certificates using Certbot
    certbot certonly --standalone --non-interactive --agree-tos \
        --email $EMAIL -d $DOMAIN --config-dir /etc/nginx/certs \
        --work-dir /etc/nginx/certs --logs-dir /etc/nginx/certs

    # Copy the certs to the right location
    cp /etc/letsencrypt/live/$DOMAIN/fullchain.pem "$CERT_FULLCHAIN"
    cp /etc/letsencrypt/live/$DOMAIN/privkey.pem "$CERT_PRIVKEY"

    echo "SSL certificates have been created and stored in $CERT_PATH."
fi
