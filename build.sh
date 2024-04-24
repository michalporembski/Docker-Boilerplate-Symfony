#!/bin/bash

emptyProject=false

if [ ! -f "./.env" ]; then
    cp ./.env.dist ./.env
fi

if [ ! -d "./application" ]; then
    mkdir application
fi

set -a
. .env
set +a

while getopts ":hn" option; do
  case $option in
    h) echo "usage: $0 [-h] [-n]"; exit ;;
    n) emptyProject=true;;
    ?) echo "error: option -$OPTARG is not implemented"; exit ;;
  esac
done

docker-compose build
docker-compose up -d

if [ ! -f "./application/composer.json" ]; then
  if $emptyProject; then
    docker-compose exec -u 1000:1000 php composer create-project symfony/website-skeleton ./
 else
    git clone $APPLICATION_GIT ./application
  fi
fi

docker-compose exec -u 1000:1000 php composer install
