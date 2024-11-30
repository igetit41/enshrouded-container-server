#!/bin/bash
git -C /home/josterhaus/enshrouded-container-server pull origin main

docker compose up -d
