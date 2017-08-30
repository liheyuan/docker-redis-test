#!/bin/bash
NODE_NAME="node-redis"
IP="192.168.99.160"
VOLUME_DATA='/var/lib/boot2docker/docker_data/redis'
docker-machine create -d virtualbox $NODE_NAME
# china mirror
docker-machine ssh $NODE_NAME "echo -e '{\n\"registry-mirrors\": [\t\"https://docker.mirrors.ustc.edu.cn\"]\n}' > ./daemon.json"
docker-machine ssh $NODE_NAME "sudo cp ./daemon.json /etc/docker/"
# change to static ip
echo "ifconfig eth1 $IP netmask 255.255.255.0 broadcast 192.168.99.255 up" | docker-machine ssh $NODE_NAME "sudo tee /var/lib/boot2docker/bootsync.sh > /dev/null"
docker-machine restart $NODE_NAME
docker-machine regenerate-certs -f $NODE_NAME
# volume dir
docker-machine ssh $NODE_NAME "sudo mkdir -p $VOLUME_DATA"
docker-machine ssh $NODE_NAME "sudo chown -R docker:staff $VOLUME_DATA"
