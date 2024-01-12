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
    redirect_to admin_user_path(user), notice: "ユーザー情報を変更しました。"
  end
  
  def destroy
    user = User.find(params[:id])
    if user.destroy
      redirect_to admin_users_path, notice: "ユーザーを削除しました。"
    else
      # エラーをログに記録するか、適切に処理する
      Rails.logger.error "ユーザーの削除中にエラーが発生しました: #{user.errors.full_messages.join(', ')}"
      redirect_to admin_users_path, alert: "ユーザーの削除中にエラーが発生しました。"
  end
  end 

  def confirm
    @user = User.find(params[:id])
    @way = params[:way]
    case @way
    when "validate"
      @way_ja = "有効"
    when "invalidate"
      @way_ja = "無効"
    when "destroy"
      @way_ja = "削除"
    end 
  end
  
end
