class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def not_logged_in
    if logged_in?
      flash[:danger] = "Please log out to create a new user."
      redirect_to root_path
    end
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end

end
