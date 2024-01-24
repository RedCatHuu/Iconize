class Admin::ClubsController < ApplicationController
  
  def show
    @club = Club.find(params[:id])
    @owner = User.find(@club.owner_id)
    @club_works = Work.where(club_id: @club.id).page(params[:page]).per(24)
    @comments = ClubComment.where(club_id: @club.id).page(params[:page]).per(100)
  end

  def index
    @clubs = Club.page(params[:page]).per(24)
  end
  
  def member
    club = Club.find(params[:id])
    @users = club.users
  end
  
end
