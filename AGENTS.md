# Render Deploy (SQLite)

```bash
# 1. Subir a GitHub
git add -A
git commit -m "cambiar a SQLite + mejoras carrito/favoritos"
git push

# 2. En Render:
# New → Web Service → conectar repo
# Build Command:
bundle install && bin/rails assets:precompile && bin/rails db:migrate
# Start Command:
bin/rails server
# Environment Variables:
RAILS_ENV=production
RAILS_MASTER_KEY=<copiar de config/master.key>
SECRET_KEY_BASE=<generar con: rails secret>
# Plan: Free
# Deploy
```

# Comandos útiles

```bash
# Generar secreto
rails secret

# Precompilar assets local
RAILS_ENV=production SECRET_KEY_BASE_DUMMY=1 bin/rails assets:precompile

# Credentials (editar)
EDITOR="code --wait" bin/rails credentials:edit
```
