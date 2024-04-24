#!/bin/bash

set -a
. .env
set +a

docker exec -it $PROJECT_NAME-php php ./vendor/bin/php-cs-fixer fix src

docker exec -it $PROJECT_NAME-php php ./vendor/bin/phpunit
docker exec -it $PROJECT_NAME-php php ./vendor/bin/phpcs src
docker exec -it $PROJECT_NAME-php php ./vendor/bin/php-cs-fixer check src
docker exec -it $PROJECT_NAME-php php ./vendor/bin/phpstan analyse -c phpstan.neon
docker exec -it $PROJECT_NAME-php php ./vendor/bin/phan --allow-polyfill-parser
