class TasksController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end
end