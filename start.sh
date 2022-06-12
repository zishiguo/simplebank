#!/usr/bin/env sh

set -ex

echo "run db migration"

export $(xargs < .env)

/app/migrate -path /app/migration -database "$DB_DRIVER://$DB_SOURCE" -verbose up

echo "start the app"
exec "$@"