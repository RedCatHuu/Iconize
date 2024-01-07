class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to my_page_user_path(user)
      flash[:notice] = "編集完了。フラッシュメッセージはいらないかも"
    else
      render :show
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
  
end
