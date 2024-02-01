class Admin::UsersController < ApplicationController
  def index
    @users = User.order(created_at: :desc).page(params[:page]).per(24)
  end

  def show
    @user = User.find(params[:id])
    @user_works = Work.where(user_id: @user.id).order(created_at: :desc).page(params[:page]).per(24)
  end

  def update
    user = User.find(params[:id])
    status = user.is_active? ? false : true
    user.update(is_active: status)
    redirect_to admin_user_path(user), notice: "ユーザー情報を更新しました。"
  end
  
  def destroy
    user = User.find(params[:id])
    Club.where(owner_id: user.id).destroy_all
    user.destroy
    redirect_to admin_users_path, notice: "ユーザーを削除しました。"
  end 

  def confirm
    @user = User.find(params[:id])
    @way = params[:way]
    case @way
    when "validate"
      @way_ja = "有効に"
    when "invalidate"
      @way_ja = "無効に"
    when "destroy"
      @way_ja = "削除"
    end 
  end
  
end
