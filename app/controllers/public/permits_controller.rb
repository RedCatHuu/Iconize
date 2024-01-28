class Public::PermitsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @club = Club.find(params[:club_id])
    permit = current_user.permits.new(club_id: @club.id)
    permit.save
    redirect_to club_path(@club), notice: "参加申請を送りました。"
    
  end
  
  def destroy
    @club = Club.find(params[:club_id])
    permit = current_user.permits.find_by(club_id: @club.id)
    permit.destroy
    redirect_to club_path(@club), alert: "参加申請を取り消しました。"
  end
  
end
