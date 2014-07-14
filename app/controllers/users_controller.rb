class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tasks = Task.all
  end
end