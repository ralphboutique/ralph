#!/usr/bin/env bash
# exit on error
if ! command -v node &> /dev/null; then
  echo "Instalando Node.js..."
  curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
  apt-get install -y nodejs
fi

# Instalar dependencias de Node.js
echo "Instalando dependencias de Node.js..."
yarn install || npm install


set -o errexit
gem update --system
bundle install
npx tailwindcss -i ./app/assets/stylesheets/application.css -o ./app/assets/builds/tailwind.css --minify
bundle exec rails assets:precompile
bundle exec rails assets:clean

# If you're using a Free instance type, you need to
# perform database migrations in the build command.

# Verificar conexión a la base de datos antes de migrar
echo "Checking database connection..."
if [ -n "$DATABASE_URL" ]; then
  echo "DATABASE_URL is set, proceeding with database setup..."
  bundle exec rails db:create
  bundle exec rails db:migrate
  bundle exec rails db:seed
else
  echo "WARNING: DATABASE_URL not set, skipping database setup"
fi