class ApplicationController < ActionController::Base
  
  protected

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    else
      root_path
    end
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys:[:name])
  end
end
