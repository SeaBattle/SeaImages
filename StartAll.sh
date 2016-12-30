#!/bin/bash

# consul
docker run -d --net=host -e 'CONSUL_LOCAL_CONFIG={"skip_leave_on_interrupt": true}' --name consul consul agent -server -bind=127.0.0.1 -bootstrap

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

# postgres
docker run -d -p 5432:5432 --name postgres -e POSTGRES_PASSWORD=postgres_password -v /home/tihon/postgres:/var/lib/postgresql/data postgres

psql -h 127.0.0.1 -U postgres -c "CREATE DATABASE seabattle;"
psql -h 127.0.0.1 -U postgres -c "CREATE USER sailor with password 'sea_wind_arrr';"
psql -h 127.0.0.1 -U postgres -c "GRANT ALL privileges ON DATABASE seabattle TO sailor;"

cd migrations
bash migrate.sh update

# user service
docker build . -t seabattle/user_service
docker run -d -p 8080:8081 --name game_service seabattle/user_service
