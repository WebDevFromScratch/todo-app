class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tasks = Task.where(user_id: @user.id)
  end
end