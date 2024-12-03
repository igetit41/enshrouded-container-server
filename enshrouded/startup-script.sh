#!/bin/bash

GITPATH=/home/d3f1l3/enshrouded-container-server

sudo git config --global --add safe.directory '*'

sudo git -C $GITPATH reset --hard
sudo git -C $GITPATH pull origin main

sudo chmod +x $GITPATH/enshrouded/enshrouded.sh

sudo cp $GITPATH/enshrouded/enshrouded.service /etc/systemd/system/enshrouded.service

sudo systemctl daemon-reload
sudo systemctl restart enshrouded

# Define the server port
SERVER_PORT=15636

# Docker container name
CONTAINER=enshrouded

# Define interval between checks for player activity (in seconds)
CHECK_INTERVAL=60

# Max Idle Intervals
IDLE_COUNT=15

# Count Idle Intervals
COUNT=0

# Main loop
while true; do
    # Check the number of established connections on the server port
    PID=$(sudo docker inspect -f '{{.State.Pid}}' $CONTAINER)
    CONNECTIONS=$(sudo nsenter -t $PID -n netstat | grep -w $SERVER_PORT | grep ESTABLISHED | wc -l)
    STAMP=$(date +'%Y-%m-%d:%H.%M:%S')
    echo "STARTUPLOG-$STAMP-CONNECTIONS: $CONNECTIONS"

    if [ $CONNECTIONS -gt 0 ]; then
        COUNT=0
    else
        COUNT=$(expr $COUNT + 1)
    fi
    echo "STARTUPLOG-$STAMP-COUNT: $COUNT"
    
    if [ $COUNT -gt $IDLE_COUNT ]; then
        echo "STARTUPLOG-$STAMP------------Shutting down"
        sudo docker compose --file $GITPATH/enshrouded/compose.yaml down
        sudo poweroff
        break
    fi

    sleep $CHECK_INTERVAL
done
