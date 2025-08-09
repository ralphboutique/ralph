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
echo "DATABASE_URL: ${DATABASE_URL:0:50}..." # Solo mostrar primeros 50 caracteres por seguridad

if [ -n "$DATABASE_URL" ]; then
  echo "DATABASE_URL is set, proceeding with database setup..."
  
  # Verificar que la base de datos sea accesible
  echo "Testing database connection..."
  bundle exec rails runner "ActiveRecord::Base.connection.execute('SELECT 1')" || echo "DB connection test failed but continuing..."
  
  bundle exec rails db:create
  bundle exec rails db:migrate
  bundle exec rails db:seed
else
  echo "ERROR: DATABASE_URL not set!"
  echo "Available environment variables:"
  env | grep -E "(DATABASE|PG)" || echo "No database environment variables found"
fi