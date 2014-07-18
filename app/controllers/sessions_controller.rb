class SessionsController < ApplicationController
  def new
    if logged_in?
      user = current_user
      redirect_to user_path(user)
    end
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:date] = Date.today #sets date to current date on login
      flash[:notice] = "You have successfully logged in"
      redirect_to user_path(user) #current_user
    else
      flash[:error] = "There is something wrong with your Username and/or Password"
      redirect_to :back
    end
  end

  def date_before
    session[:date] = session[:date].to_date - 1 #.to_s is called automatically
    redirect_to user_path(current_user)
  end

  def date_after
    session[:date] = session[:date].to_date + 1
    redirect_to user_path(current_user)
  end

  def destroy
    session[:user_id] = nil

    flash[:notice] = "You have successfully logged out"
    redirect_to root_path
  end
end