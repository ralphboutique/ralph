class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
def after_sign_out_path_for(resource_or_scope)
  new_user_session_path
end
def after_sign_in_path_for(resource)
  admin_path
end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
  end
end
