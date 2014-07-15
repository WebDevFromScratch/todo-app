class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user) #current_user
    else
      flash[:error] = "There is something wrong with your Username and/or Password"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil

    flash[:notice] = "You have successfully logged out"
    redirect_to login_path #change this to sth that makes sense later
  end
end