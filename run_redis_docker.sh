#!/bin/bash
NODE_NAME="node-redis"
DOCKER_NAME="sbmvt-redis"
VOLUME_DATA='/var/lib/boot2docker/docker_data/redis'
eval $(docker-machine env $NODE_NAME)
last_id=$(docker ps -l -q)
docker rm -f $last_id
docker run --rm --name $DOCKER_NAME -v "$VOLUME_DATA":/data -p6379:6379 -d redis:4-alpine redis-server --appendonly yes
