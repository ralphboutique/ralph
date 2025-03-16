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
    @roles = Rol.all
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @roles = Rol.all
    if @user.save
      redirect_to show_user_path, notice: 'Usuario creado exitosamente.'
    else
      render :new
    end
  end

  # GET /users/:id/edit
  def edit
    @user = User.find(params[:id])
    @roles = Rol.all
  end

  # PATCH/PUT /users/:id
  def update
    @user = User.find(params[:id])
    @roles = Rol.all
    if @user.update(user_params)
      redirect_to show_user_path, notice: 'Usuario actualizado exitosamente.'
    else
      render :edit
    end
  end

  # DELETE /users/:id
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to show_user_path, notice: 'Usuario eliminado exitosamente.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :rol_id)
  end
end

