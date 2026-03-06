#!/bin/bash

set -e

BRANCH=${1:-main}
REPO_URL="git@github.com:mananurrehman/Vitual-Browser-DevOpsShack.git"
APP_DIR="$HOME/VB-DevOpsShack"

echo "-----------------------------------"
echo "Starting deployment..."
echo "Branch: $BRANCH"
echo "Directory: $APP_DIR"
echo "-----------------------------------"

# Check if repo exists
if [ ! -d "$APP_DIR/.git" ]; then
    echo "Repository not found. Cloning..."
    git clone -b $BRANCH $REPO_URL $APP_DIR
else
    echo "Repository exists. Pulling latest changes..."
    cd $APP_DIR
    git fetch origin
    git checkout $BRANCH
    git pull origin $BRANCH
fi

cd $APP_DIR

echo "Stopping old containers..."
docker compose down || true

echo "Building and starting containers..."
docker compose up -d --build

echo "Cleaning unused images..."
docker image prune -f

echo "-----------------------------------"
echo "Deployment finished successfully"
echo "-----------------------------------"