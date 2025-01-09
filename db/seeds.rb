# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
rol_admin = Rol.find_or_create_by(id: 1) do |rol|
  rol.name = 'ADMIN'
end

# Crear un usuario administrador asociado al rol ADMIN
User.find_or_create_by(username: 'admin') do |user|
  user.email = 'admin@tudominio.com'         # Cambia por un email válido
  user.password = 'password123'              # Cambia por una contraseña segura
  user.password_confirmation = 'password123' # Confirmación de contraseña
  user.rol_id = rol_admin.id                 # Asocia el usuario al rol ADMIN
end