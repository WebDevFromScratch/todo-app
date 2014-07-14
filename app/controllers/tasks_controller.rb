class TasksController < ApplicationController
  def show
    @task = Task.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @task = Task.new
    @categories = Category.all
  end

  def create
    @user = User.find(params[:user_id])
    @task = Task.new(task_params)
    @task.user_id = params[:user_id]

    binding.pry

    if @task.save
      flash[:notice] = "Your task was created!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :user_id, :category_id, 
      :priority)
  end
end