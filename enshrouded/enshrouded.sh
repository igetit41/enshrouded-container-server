#!/bin/bash
git -C /home/d3f1l3/enshrouded-container-server reset --hard
git -C /home/d3f1l3/enshrouded-container-server pull origin main
chmod +x /home/d3f1l3/enshrouded-container-server/enshrouded/enshrouded.sh
cp /home/d3f1l3/enshrouded-container-server/enshrouded/enshrouded.service /etc/systemd/system/enshrouded.service

docker-compose up -d
