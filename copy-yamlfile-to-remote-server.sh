#!/bin/bash

KEY="ai-cloud-key"
USER="ubuntu"
SERVER="54.174.68.162"
REMOTE_DIR="/home/ubuntu/"

scp -r -i terraform/"$KEY" \
docker-compose.yml prometheus/ \
"$USER"@"$SERVER":"$REMOTE_DIR"
