#!/bin/bash

dockercompose=$1

# Pull images
docker-compose pull
docker-compose -f ${dockercompose} up -d --build --force-recreate
