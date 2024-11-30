#!/bin/bash
export GITPATH=/home/d3f1l3/enshrouded-container-server/
export GITSERVICEPATH=enshrouded/

git -C ${$GITPATH} reset --hard
git -C ${$GITPATH} pull origin main
chmod +x ${$GITPATH}${$GITSERVICEPATH}enshrouded.sh
cp ${$GITPATH}${$GITSERVICEPATH}enshrouded.service /etc/systemd/system/enshrouded.service

docker compose --file ${$GITPATH}${$GITSERVICEPATH}compose.yaml up -d
