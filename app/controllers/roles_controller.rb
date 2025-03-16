class RolesController < ApplicationController
  def show
    if params[:query].present?
      @roles =  Rol.where('name ILIKE ?', "%#{params[:query]}%").page(params[:page]).per(5)
    else
      @roles = Rol.page(params[:page]).per(5)
    end
  end

  def new
    @rol = Rol.new
  end

  def create
    @rol = Rol.new(rol_params)
    if @rol.save
      redirect_to show_roles_path, notice: 'ROL creado exitosamente'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @rol = Rol.find(params[:id])
  end

  def update
    @rol = Rol.find(params[:id])
    if @rol.update(rol_params)
      redirect_to show_roles_path, notice: 'ROL editado exitosamente'
    else
      render :edit
    end
  end
  def destroy
    @rol = Rol.find(params[:id])
   if @rol.destroy
    redirect_to show_roles_path, notice: 'ROL eliminado exitosamente.'
   else 
    redirect_to show_roles_path, alert: 'No se ha podido eliminar porque esta asociado a un usuario.'
   end 
  end

  private
  def rol_params
    params.require(:rol).permit(:name)
  end
end
