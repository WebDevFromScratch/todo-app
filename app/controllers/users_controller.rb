class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    default_categories = Category.all[0..2]
    @user.categories << default_categories

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You have successfully registered"
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @tasks = Task.where(user_id: @user.id)
    @tasks_in_progress = @tasks.where({accomplished: false}).order(:priority).all.reverse
    @tasks_accomplished = @tasks.where({accomplished: true}).order(:priority).all.reverse
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:message] = "Your profile has been updated"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :slug)
  end

  def set_user
    @user = User.find_by(slug: params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:error] = "You're not allowed to do that"
      redirect_to root_path
    end
  end
end