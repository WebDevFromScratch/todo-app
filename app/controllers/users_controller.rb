class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:show, :edit, :update]
  before_action :set_user_for_category, only: [:show_categories, :add_category, 
                                              :remove_category]
  before_action :set_category, only: [:add_category, :remove_category]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    default_categories = Category.all[0..2] #these 'default' categories need to be created manually for the db
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
    @tasks = Task.where(user_id: @user.id).where(deadline: set_date)
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

  def show_categories
    @other_categories = categories_without_user_categories
  end

  def add_category
    @user.categories << @category

    flash[:notice] = "#{@category.name} was added to your categories"
    redirect_to user_my_categories_path(@user)
  end

  def remove_category
    @user.categories.delete(@category)

    flash[:notice] = "#{@category.name} was removed from your categories"
    redirect_to user_my_categories_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :slug)
  end

  def set_user
    @user = User.find_by(slug: params[:id])
  end

  def set_user_for_category
    @user = User.find_by(slug: params[:user_id])
  end

  def set_category
    @category = Category.find(params[:format])
  end

  def require_same_user
    if current_user != @user
      flash[:error] = "You're not allowed to do that"
      redirect_to root_path
    end
  end

  def categories_without_user_categories
    other_categories = Array.new
    Category.all.each do |category|
      other_categories << category
    end

    @user.categories.each do |category|
      if other_categories.include?(category)
        other_categories.delete(category)
      end
    end

    other_categories.sort_by! { |category| category.name }
    other_categories
  end
end