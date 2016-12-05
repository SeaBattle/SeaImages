#!/bin/bash

# consul
docker run -d --net=host -e 'CONSUL_LOCAL_CONFIG={"skip_leave_on_interrupt": true}' consul agent -server -bind=127.0.0.1 -bootstrap

# add game for config
curl -X PUT -d 'seabattle' "http://127.0.0.1:8500/v1/kv/game_service/games"

# game service
docker build . -t seabattle/game_service
docker run -d -p 8080:8080 --name game_service seabattle/game_service

# registrator
docker run -d \
    --name=registrator \
    --net=host \
    --volume=/var/run/docker.sock:/tmp/docker.sock \
    gliderlabs/registrator:latest \
      consul://localhost:8500
