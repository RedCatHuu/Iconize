class Public::UsersController < ApplicationController
  
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]
  before_action :authenticate_user!
  
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
      redirect_to my_page_user_path(@user), notice: "編集が。"
    else
      render :edit
    end
  end

  def confirm
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    reset_session
    redirect_to root_path, notice: "退会しました。ご利用ありがとうございました。"
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
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end 
  end 
  
end
