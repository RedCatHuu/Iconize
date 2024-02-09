class Public::UsersController < ApplicationController
  
  before_action :ensure_guest_user, only: [:edit]
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  
  def show
    @user = User.find(params[:id])
    @user_works = Work.where(user_id: @user.id, is_published: true).created_at_desc.page(params[:page]).per(24)
    favorited_works = @user.favorited_works.public.created_at_desc
    @favorited_works_size = favorited_works.size
    @favorited_works = favorited_works.page(params[:page]).per(24)
    @clubs = @user.clubs.page(params[:page]).per(24)
  end

  def edit
  end

  def update
    # @にしないとエラーに送れない
    if @user.update(user_params)
      redirect_to my_page_user_path(@user), notice: "ユーザー情報を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    Club.where(owner_id: @user.id).destroy_all
    @user.destroy
    reset_session
    redirect_to root_path, notice: "退会しました。ご利用ありがとうございました。"
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end 
  
  def is_matching_login_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to my_page_user_path(current_user), alert: "不正なアクセスです。"
    end
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to my_page_user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end 
  end 
  
end
