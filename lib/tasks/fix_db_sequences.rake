namespace :db do
  desc "Reset database sequences and fix unique constraint violations"
  task fix_sequences: :environment do
    puts "🔧 Iniciando corrección de secuencias y duplicados..."
    
    ActiveRecord::Base.transaction do
      # 1. Limpiar duplicados en roles
      puts "📋 Limpiando duplicados en roles..."
      
      # Encontrar duplicados por nombre
      duplicates = Role.group(:name).having('count(*) > 1').count
      
      duplicates.each do |name, count|
        puts "  - Encontrados #{count} roles con nombre '#{name}'"
        roles_with_name = Role.where(name: name).order(:id)
        
        # Mantener el primero, eliminar los demás
        roles_to_delete = roles_with_name[1..-1]
        roles_to_delete.each do |role|
          # Primero mover usuarios al primer rol
          User.where(role_id: role.id).update_all(role_id: roles_with_name.first.id)
          # Luego eliminar permisos del rol duplicado
          RolePermission.where(role_id: role.id).destroy_all
          # Finalmente eliminar el rol duplicado
          role.destroy
          puts "    ✓ Eliminado rol duplicado ID: #{role.id}"
        end
      end
      
      # 2. Limpiar duplicados en usuarios
      puts "👥 Limpiando duplicados en usuarios..."
      
      # Duplicados por email
      User.group(:email).having('count(*) > 1').count.each do |email, count|
        puts "  - Encontrados #{count} usuarios con email '#{email}'"
        users_with_email = User.where(email: email).order(:id)
        users_to_delete = users_with_email[1..-1]
        users_to_delete.each do |user|
          user.destroy
          puts "    ✓ Eliminado usuario duplicado ID: #{user.id}"
        end
      end
      
      # Duplicados por username
      User.group(:username).having('count(*) > 1').count.each do |username, count|
        next if username.blank?
        puts "  - Encontrados #{count} usuarios con username '#{username}'"
        users_with_username = User.where(username: username).order(:id)
        users_to_delete = users_with_username[1..-1]
        users_to_delete.each do |user|
          user.destroy
          puts "    ✓ Eliminado usuario duplicado ID: #{user.id}"
        end
      end
      
      # 3. Resetear secuencias para PostgreSQL
      if ActiveRecord::Base.connection.adapter_name.downcase.include?('postgresql')
        puts "🔄 Reseteando secuencias de PostgreSQL..."
        
        tables_to_reset = %w[roles users permissions areas role_permissions]
        
        tables_to_reset.each do |table|
          if ActiveRecord::Base.connection.table_exists?(table)
            max_id = ActiveRecord::Base.connection.select_value("SELECT COALESCE(MAX(id), 0) FROM #{table}")
            next_id = max_id + 1
            
            sequence_name = "#{table}_id_seq"
            ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{sequence_name} RESTART WITH #{next_id}")
            puts "  ✓ Secuencia #{sequence_name} reseteada a #{next_id}"
          end
        end
      end
      
      puts "✅ Corrección completada exitosamente!"
    end
    
  rescue StandardError => e
    puts "❌ Error durante la corrección: #{e.message}"
    puts "🔄 Haciendo rollback de los cambios..."
    raise e
  end
  
  desc "Show database statistics"
  task show_stats: :environment do
    puts "\n📊 Estadísticas de la base de datos:"
    puts "================================="
    
    [Role, User, Permission, Area, RolePermission].each do |model|
      count = model.count
      max_id = model.maximum(:id) || 0
      puts "#{model.name.ljust(15)}: #{count.to_s.rjust(3)} registros (max ID: #{max_id})"
    end
    
    puts "\n🔍 Verificando duplicados:"
    puts "========================="
    
    # Roles duplicados
    role_duplicates = Role.group(:name).having('count(*) > 1').count
    if role_duplicates.any?
      puts "⚠️  Roles duplicados encontrados:"
      role_duplicates.each { |name, count| puts "  - '#{name}': #{count} veces" }
    else
      puts "✅ No hay roles duplicados"
    end
    
    # Usuarios duplicados por email
    email_duplicates = User.group(:email).having('count(*) > 1').count
    if email_duplicates.any?
      puts "⚠️  Emails duplicados encontrados:"
      email_duplicates.each { |email, count| puts "  - '#{email}': #{count} veces" }
    else
      puts "✅ No hay emails duplicados"
    end
    
    # Usuarios duplicados por username
    username_duplicates = User.where.not(username: nil).group(:username).having('count(*) > 1').count
    if username_duplicates.any?
      puts "⚠️  Usernames duplicados encontrados:"
      username_duplicates.each { |username, count| puts "  - '#{username}': #{count} veces" }
    else
      puts "✅ No hay usernames duplicados"
    end
  end
end