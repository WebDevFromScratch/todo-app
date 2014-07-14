class UsersController < ApplicationController
  def show
    #@user = User.first #hardcoded for now
    @user = User.find(params[:id])
  end
end