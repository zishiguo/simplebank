#!/usr/bin/env sh

set -e

echo "run db migration"

export "$(grep -v '^#' app.env | xargs -0)"

/app/migrate -path /app/migration -database "$DB_DRIVER://$DB_SOURCE" -verbose up

echo "start the app"
exec "$@"