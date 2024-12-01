#!/bin/bash
export GITPATH=/home/d3f1l3/enshrouded-container-server

git -C $GITPATH reset --hard
git -C $GITPATH pull origin main
chmod +x $GITPATH/enshrouded/enshrouded.sh
cp $GITPATH/enshrouded/enshrouded.service /etc/systemd/system/enshrouded.service

docker compose --file $GITPATH/enshrouded/compose.yaml up -d
