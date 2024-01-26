class Admin::ClubsController < ApplicationController
  
  def show
    @club = Club.find(params[:id])
    @owner = User.find(@club.owner_id)
    @club_works = Work.where(club_id: @club.id).order(created_at: :desc).page(params[:page]).per(24)
    @comments = ClubComment.where(club_id: @club.id).order(created_at: :desc).page(params[:page]).per(100)
  end

  def index
    @clubs = Club.page(params[:page]).order(created_at: :desc).per(24)
  end
  
  def member
    club = Club.find(params[:id])
    @users = club.users.page(params[:page]).per(24)
  end
  
end
