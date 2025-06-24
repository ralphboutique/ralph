module ApplicationHelper
  def has_permission?(area_name, permission_name)
    area = Area.find_by(name: area_name)
    perm = Permission.find_by(name: permission_name)
    return false unless area && perm
  
    current_user.role.role_permissions.exists?(area_id: area.id, permission_id: perm.id)
  end
end
