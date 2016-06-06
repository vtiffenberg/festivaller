class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!, except: :public_home

  def public_home
    render 'shared/home'
  end

  def settings
    render '/shared/settings'
  end
end
