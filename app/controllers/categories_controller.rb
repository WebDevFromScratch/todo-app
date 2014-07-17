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

  private

  def category_params
    params.require(:category).permit(:name)
  end
end