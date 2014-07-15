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

    if @task.save
      flash[:notice] = "Your task was created"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @task = Task.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:notice] = "Your task was updated"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @task = Task.find(params[:id])

    @task.destroy
    flash[:notice] = "Your task was removed"
    redirect_to user_path(@user)
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :user_id, :category_id, 
      :priority)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_task

  end
end