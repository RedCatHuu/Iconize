class Public::ClubsController < ApplicationController
  
  before_action :ensure_correct_user, only: [:edit, :update, :permit]
  before_action :authenticate_user!, except: [:index]

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

  def myclub
  end
  
  def member
    @club = Club.find(params[:id])
  end
  
  def permit
    @club = Club.find(params[:id])
    @permits = @club.permits
  end 
  
  def accept
    club = Club.find(params[:club_id])
    permit = Permit.find(params[:permit_id])
    club.users << permit.user
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
