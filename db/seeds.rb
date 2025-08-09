# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# 1. Crear permisos base
%w[Ver Crear Editar Eliminar].each do |perm_name|
  Permission.find_or_create_by(name: perm_name)
end

# 2. Crear áreas
[
  "Articulos",
  "Usuarios",
  "Categorias",
  "Almacenes",
  "Tallas",
  "Roles",
  "Gestion de Inventario",
  "Ventas Directas",
  "Venta a credito"
].each do |mod_name|
  Area.find_or_create_by(name: mod_name)
end

# 3. Crear rol ADMIN
rol_admin = Role.find_or_create_by(name: 'ADMIN')

# 4. Asignar todos los permisos de todas las áreas al rol ADMIN
Area.all.each do |area|
  Permission.all.each do |perm|
    RolePermission.find_or_create_by(role_id: rol_admin.id, area_id: area.id, permission_id: perm.id)
  end
end

# 5. Crear usuario administrador con rol ADMIN
User.find_or_create_by(username: 'admin') do |user|
  user.email = 'admin@tudominio.com'
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.role_id = rol_admin.id
  user.status = 'active'
end

# 6. Crear categorías de ejemplo
categorias_ejemplo = [
  "Vestidos",
  "Blusas", 
  "Pantalones",
  "Zapatos",
  "Accesorios"
]

categorias_ejemplo.each do |cat_name|
  Category.find_or_create_by(title: cat_name)
end

# 7. Crear almacén de ejemplo
warehouse = Warehouse.find_or_create_by(title: "Almacén Principal")

# 8. Crear tallas de ejemplo
tallas_ejemplo = ["XS", "S", "M", "L", "XL", "XXL"]
tallas_ejemplo.each do |size_name|
  Size.find_or_create_by(title: size_name)
end
