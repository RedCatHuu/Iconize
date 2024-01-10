class Public::UsersController < ApplicationController
  
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    # @にしないとエラーに送れない
    if @user.update(user_params)
      redirect_to my_page_user_path(@user)
      flash[:notice] = "編集完了。フラッシュメッセージはいらないかも"
    else
      render :edit
    end
  end

  def confirm
  end

  def exit
  end

  def following
  end

  def followers
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end 
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to my_page_user_path(current_user)
    end
  end
  
end
