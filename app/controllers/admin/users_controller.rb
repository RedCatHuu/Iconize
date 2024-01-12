class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.is_active == true
      user.update(is_active: false)
    else
      user.update(is_active: true)
    end
    redirect_to admin_user_path(user)
  end

  def confirm
    @user = User.find(params[:id])
    @status = @user.is_active
  end
  
end
