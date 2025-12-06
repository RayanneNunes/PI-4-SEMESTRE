#!/bin/sh
set -e

# Carrega .env se existir
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs) || true
fi

# Migrações
if [ -z "$SKIP_MIGRATE" ]; then
  echo "==> Executando migrations..."
  python manage.py migrate --noinput
fi

# Collectstatic
if [ -z "$SKIP_COLLECTSTATIC" ]; then
  echo "==> Executando collectstatic..."
  python manage.py collectstatic --noinput --clear || true
fi

# Executa o comando final
exec "$@"
