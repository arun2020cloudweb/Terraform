#!/bin/bash -ex

echo Begin: user-data

echo Begin: update and install packages
yum update -y
yum install -y aws-cli jq
echo End: update and install packages


echo Begin: start ECS
cluster="${cluster_name}"
echo ECS_CLUSTER=$cluster >> /etc/ecs/ecs.config
start ecs
until $(curl --output /dev/null --silent --head --fail http://localhost:51678/v1/metadata); do
  printf '.'
  sleep 1
done
echo End: start ECS


echo End: user-data

