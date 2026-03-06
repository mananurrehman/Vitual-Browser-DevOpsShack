#!/bin/bash

set -e

APP_DIR="$HOME/VB-DevOpsShack"

echo "-----------------------------------"
echo "Starting deployment..."
echo "-----------------------------------"

# ensure directory exists
mkdir -p $APP_DIR
cd $APP_DIR

echo "Pulling latest image from DockerHub..."
docker compose pull

echo "Restarting containers..."
docker compose up -d

echo "Cleaning old images..."
docker image prune -f

echo "-----------------------------------"
echo "Deployment completed successfully"
echo "-----------------------------------"
