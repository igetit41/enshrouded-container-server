#!/bin/bash
export GITPATH=/home/d3f1l3/enshrouded-container-server
export GITSERVICEPATH=$GITPATH/enshrouded

git -C $GITPATH reset --hard
git -C $GITPATH pull origin main
chmod +x $GITSERVICEPATH/enshrouded.sh
cp $GITSERVICEPATH/enshrouded.service /etc/systemd/system/enshrouded.service

docker compose --file $GITSERVICEPATH/compose.yaml up -d
