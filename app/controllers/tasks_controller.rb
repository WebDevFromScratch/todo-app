class TasksController < ApplicationController
  def show
    @task = Task.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @task = Task.new
  end

  def create
    @user = User.find(params[:user_id])
    @task = Task.new(task_params)
    @task.user_id = params[:user_id]

    if @task.save
      flash[:notice] = "Your task was created!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :user_id)
  end
end