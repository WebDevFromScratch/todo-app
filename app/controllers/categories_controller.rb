class CategoriesController < ApplicationController
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
    @user = current_user
    @category = Category.find(params[:id])
    @tasks = Task.where(user_id: @user.id).where(category_id: @category.id)
    @tasks_in_progress = @tasks.where({accomplished: false}).order(:priority).all.reverse
    @tasks_accomplished = @tasks.where({accomplished: true}).order(:priority).all.reverse
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end