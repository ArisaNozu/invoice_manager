class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :basic_auth

  protected
  def configure_permitted_parameters
    keys = [:full_name, :employee_number, :department]
    devise_parameter_sanitizer.permit(:sign_up,        keys: keys)
    devise_parameter_sanitizer.permit(:account_update, keys: keys)
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"] 
    end
  end

end
