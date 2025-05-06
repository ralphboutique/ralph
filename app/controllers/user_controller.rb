class UserController < ApplicationController
  def show
    if params[:query].present?
      @users =  User.where('username ILIKE ?', "%#{params[:query]}%").page(params[:page]).per(5)
    else
      @users = User.page(params[:page]).per(5)
    end
  end
  # GET /users/new
  def new
    @user = User.new
    @roles = Role.all
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.status = "active"
    @roles = Role.all
    if @user.save
      redirect_to show_user_path, notice: 'Usuario creado exitosamente.'
    else
      render :new
    end
  end

  # GET /users/:id/edit
  def edit
    @user = User.find(params[:id])
    @roles = Role.all
  end

  # PATCH/PUT /users/:id
  def update
    @user = User.find(params[:id])
    @roles = Role.all
  if params[:user][:password].blank?
    params[:user].delete(:password)
    params[:user].delete(:password_confirmation)
  end
    if @user.update(user_params)
      redirect_to show_user_path, notice: 'Usuario actualizado exitosamente.'
    else
      render :edit
    end
  end

  # DELETE /users/:id
  def destroy
    @user = User.find(params[:id])
    if @user.sales.exists?
      redirect_to show_user_path(@user), alert: "No se puede eliminar porque tiene ventas asociadas."
    else
      @user.destroy
      redirect_to show_user_path, notice: "Usuario eliminado exitosamente."
    end
  end
  def toggle_status
    @user = User.find(params[:id])
    
    @user.update(status: @user.status == "active" ? "inactive" : "active")

    redirect_to show_user_path, notice: "El estado del Usuario se ha actualizado correctamente."
  end
  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :role_id,  warehouse_ids: [])
  end
end

