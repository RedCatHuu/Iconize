class Public::RelationshipsController < ApplicationController
  
  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
    # redirect_to request.referer
    render :relation
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(@user)
    # redirect_to request.referer
    render :relation
  end
  
  def following
    user = User.find(params[:id])
    @following = user.following
  end 
  
  def followers
    user = User.find(params[:id])
    @followers = user.followers
  end 
end
