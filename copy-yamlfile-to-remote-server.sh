#!/bin/bash

KEY="ai-cloud-key"
USER="ubuntu"
SERVER="54.225.138.102"
REMOTE_DIR="/home/ubuntu/"

scp -r -i terraform/key-pair/"$KEY" \
docker-compose.yml prometheus/ \
"$USER"@"$SERVER":"$REMOTE_DIR"
