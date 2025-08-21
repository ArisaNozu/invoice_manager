class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    keys = [:full_name, :employee_number, :department]
    devise_parameter_sanitizer.permit(:sign_up,        keys: keys)
    devise_parameter_sanitizer.permit(:account_update, keys: keys)
  end
end
