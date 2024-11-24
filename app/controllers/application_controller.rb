class ApplicationController < ActionController::API
  def current_user
    return nil unless session[:user_name]
    @current_user ||= User.find_or_create_by(name: session[:user_name])
  end

  def login_as(name)
    session[:user_name] = name
  end
end
