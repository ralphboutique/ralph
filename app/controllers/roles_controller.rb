class RolesController < ApplicationController
  def show
    if params[:query].present?
      @roles =  Role.where('name ILIKE ?', "%#{params[:query]}%").page(params[:page]).per(5)
    else
      @roles = Role.page(params[:page]).per(5)
    end
  end

  def new
    @rol = Role.new
  end

  def create
    @rol = Role.new(rol_params)
    if @rol.save
      params[:permissions]&.each do |pair|
        area_id, perm_id = pair.split('-')
        RolePermission.create(role: @rol, area_id: area_id, permission_id: perm_id)
      end
      redirect_to show_roles_path, notice: 'Rol creado correctamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @rol = Role.find(params[:id])
  end

  def update
    @rol = Role.find(params[:id])
    if @rol.update(rol_params)
      @rol.role_permissions.destroy_all

      params[:permissions]&.each do |pair|
        area_id, perm_id = pair.split('-')
        RolePermission.create(role: @rol, area_id: area_id, permission_id: perm_id)
      end
  
      redirect_to show_roles_path, notice: 'Rol actualizado correctamente.'
    else
      render :edit
    end
  end
  def destroy
    @rol = Role.find(params[:id])
    @rol.role_permissions.destroy_all 

   if @rol.destroy
    redirect_to show_roles_path, notice: 'Rol eliminado exitosamente.'
   else 
    redirect_to show_roles_path, alert: 'No se ha podido eliminar porque esta asociado a un usuario.'
   end 
  end

  private
  def rol_params
    params.require(:role).permit(:name)
  end
end
