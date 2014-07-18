class CategoriesController < ApplicationController
  before_action :require_user, only: [:new, :create]
  before_action :set_user, only: [:show]
  before_action :require_same_user, only: [:show]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @user = current_user

    if @category.save
      @user.categories << @category
      flash[:notice] = "#{@category.name} has been created and added to your categories"
      redirect_to user_my_categories_path(@user)
    else
      render :new
    end
  end

  def show
    @category = Category.find(params[:id])
    @tasks = Task.where(user_id: @user.id).where(category_id: @category.id)
    @tasks_in_progress = @tasks.where({accomplished: false}).order(:priority).all.reverse
    @tasks_accomplished = @tasks.where({accomplished: true}).order(:priority).all.reverse
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_user
    @user = current_user
  end

  def require_same_user
    if !logged_in? || current_user != @user
      flash[:error] = "You're not allowed to do that"
      redirect_to root_path
    end
  end
end