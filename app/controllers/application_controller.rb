class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
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
  
  def guest_check
    if current_user.name == "ゲスト"
      flash[:notice] = "このページを見るには会員登録が必要です。"
      redirect_to root_path
    end
  end
end
