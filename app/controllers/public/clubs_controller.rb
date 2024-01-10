class Public::ClubsController < ApplicationController
  
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :authenticate_user!, except: [:index, ]

  def new
  end

  def index
    @clubs = Club.all
  end

  def show
    @club = Club.find(params[:id])
    @owner = User.find_by(id: @club.owner_id)
  end
  
  def create
    club = Club.new(club_params)
    club.owner_id = current_user.id
    club.users << current_user
    if club.save
      flash[:notice] = "サークルを作成しました。"
      redirect_to club_path(club)
    else
      flash[:alert] = "サークルの作成に失敗しました。"
      render :new
    end 
  end 

  def edit
    @club = Club.find(params[:id])
  end

  def update
  end

  def myclub
  end
  
  def invite
    club = club.find(params[:club_id])
    club.users << current_user
    redirect_to club_path(club)
  end 
  
  def leave
    club = club.find(params[:club_id])
    club.users.delete(current_user)
    redirect_to clubs_path
  end 
  
  private
  
  def club_params
    params.require(:club).permit(:name, :introduction, :club_image)
  end 
  
  def ensure_correct_user
    @club = Club.find(params[:id])
    unless @club.owner_id == current_user.id
      redirect_to clubs_path
    end
  end
  
end
