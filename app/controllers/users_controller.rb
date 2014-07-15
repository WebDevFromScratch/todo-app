class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "You have successfully registered"
      redirect_to user_path(@user)
    else
      binding.pry
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = Task.where(user_id: @user.id)
  end
end

private

def user_params
  params.require(:user).permit(:username, :password, :password_confirmation)
end