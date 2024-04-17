#!/bin/bash

set -a
. .env
set +a

docker exec -it $PROJECT_NAME-php php ./vendor/bin/phpunit
