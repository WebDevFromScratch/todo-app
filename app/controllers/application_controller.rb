class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :set_date

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def set_date
    @set_date ||= session[:date]
  end

  def require_user
    access_denied unless logged_in?
  end

  def require_no_user
    access_denied if logged_in?
  end

  #def require_same_user
  #  access_denied if (logged_in? || current_user != @user)
  #end

  def access_denied
    flash[:error] = "You are not allowed to do that"
    redirect_to root_path
  end
end
