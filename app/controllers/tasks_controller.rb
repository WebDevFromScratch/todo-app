class TasksController < ApplicationController
  before_action :set_user
  before_action :set_task, only: [:edit, :update, :destroy]
  before_action :set_categories, only: [:new, :create, :edit, :update]

  before_action :require_user

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = @user.id

    if @task.save
      flash[:notice] = "Your task was created"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:notice] = "Your task was updated"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = "Your task was removed"
    redirect_to user_path(@user)
  end

  def accomplished
    @task = Task.find(params[:task_id])
    @task.mark_accomplished
    @task.save

    respond_to do |format|
      format.html do
        flash[:notice] = "Task accomplished"
        redirect_to user_path(@user)
      end
      format.js #empty just renders a proper template
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :user_id, :category_id, 
      :priority, :accomplished, :deadline)
  end

  def set_user
    @user = User.find_by(slug: params[:user_id])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def set_categories
    @categories = @user.categories
  end
end