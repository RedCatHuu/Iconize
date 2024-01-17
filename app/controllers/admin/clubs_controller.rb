class Admin::ClubsController < ApplicationController
  
  def show
    @club = Club.find(params[:id])
    @owner = User.find(@club.owner_id)
  end

  def index
    @clubs = Club.all
  end
  
  def member
    club = Club.find(params[:id])
    @users = club.users
  end
  
end
