#!/bin/bash

# database
docker run --name mongodb -d mongo:3.3

# cache
docker run --name redis -d redis:3

# configuration
docker build --tag seabattle/etcd Etcd/
docker run -p 2379:2379 --name etcd -d seabattle/etcd
 
# user service
docker build --tag seabattle/user_service UserService/
docker run --name user_service --link mongodb:mongo --link redis:redis --link etcd:etcd -h user_service.sb -t -i -p 8080:8080 seabattle/user_service /bin/bash
