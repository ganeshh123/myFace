class ApplicationController < ActionController::Base


  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  include PublicActivity::StoreController 

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar, :username, :email, :password, :password_confirmation, :current_password])
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :username, :email, :password, :password_confirmation])
    end


end
