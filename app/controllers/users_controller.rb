class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :require_same_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      current_user = @user
      flash[:notice] = "You have successfully registered"
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @tasks = Task.where(user_id: @user.id)
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:error] = "You're not allowed to do that"
      redirect_to login_path #change later
    end
  end
end