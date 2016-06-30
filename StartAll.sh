#!/bin/bash

# database
docker run --name mongodb -d mongo:3.3

# cache
docker run --name redis -d redis:3

# configuration
docker run -d -v /usr/share/ca-certificates/:/etc/ssl/certs -p 4001:4001 -p 2380:2380 -p 2379:2379 \
 --name etcd quay.io/coreos/etcd \
 -name etcd0 \
 -listen-client-urls http://0.0.0.0:2379,http://0.0.0.0:4001 \
 -listen-peer-urls http://0.0.0.0:2380 \
 -initial-cluster-token etcd-cluster-1 \
 -initial-cluster-state new
 
# user service
docker build --tag seabattle/user_service UserService/
docker run --name user_service --link mongodb:mongo --link redis:redis --link etcd:etcd -h user_service.sb -t -i -p 8080:8080 seabattle/user_service /bin/bash
