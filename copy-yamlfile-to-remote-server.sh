#!/bin/bash

KEY="ai-cloud-key"
USER="ubuntu"
SERVER="32.199.33.16"
REMOTE_DIR="/home/ubuntu/"

# copy folders recursively and files from the local server to the remote server
scp -r -i terraform/key-pair/"$KEY" \
docker-compose.yml prometheus/ \
"$USER"@"$SERVER":"$REMOTE_DIR"
