class Public::ClubsController < ApplicationController
  
  before_action :ensure_correct_user, only: [:edit, :update, :permit]
  before_action :authenticate_user!, except: [:index]

  def new
  end

  def index
    @clubs = Club.page(params[:page]).per(24)
  end

  def show
    @club = Club.find(params[:id])
    @owner = User.find_by(id: @club.owner_id)
    @club_works = Work.where(club_id: @club.id, is_published: true).page(params[:page]).per(24)
    @comments = ClubComment.where(club_id: @club.id).page(params[:page]).per(100)
  end
  
  def create
    club = Club.new(club_params)
    club.owner_id = current_user.id
    club.users << current_user
    if club.save
      redirect_to club_path(club), notice: "サークルを作成しました。"
    else
      flash[:alert] = "サークルの作成に失敗しました。"
      render :new
    end 
  end 

  def edit
    @club = Club.find(params[:id])
  end

  def update
    @club = Club.find(params[:id])
    if @club.update(club_params)
      redirect_to club_path(@club), notice: "サークル情報を編集しました。"
    else
      render :edit
    end
  end

  def club_works
    @works = Work
  end
  
  def member
    @club = Club.find(params[:id])
  end
  
  def permit
    @club = Club.find(params[:id])
  end 
  
  def accept
    club = Club.find(params[:club_id])
    user = User.find(params[:user_id])
    permit = Permit.find_by(club_id: club.id, user_id: user.id )
    club.users << user
    permit.destroy
    redirect_to permit_club_path(club)
  end 
  
  def leave
    club = Club.find(params[:id])
    club.users.delete(current_user)
    redirect_to clubs_path, notice: "サークルを脱退しました。"
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
