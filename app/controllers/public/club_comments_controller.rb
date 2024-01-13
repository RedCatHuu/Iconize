class Public::ClubCommentsController < ApplicationController
  
  def create
    @club = Club.find(params[:club_id])
    @comment = current_user.club_comments.new(club_comment_params)
    @comment.club_id = @club.id
    @comment.save
  end

  def destroy
    comment = ClubComment.find(params[:id])
    @club = comment.club
    comment.destroy
  end
  
  private
  
  def club_comment_params
    params.require(:club_comment).permit(:comment)
  end 
  
end
