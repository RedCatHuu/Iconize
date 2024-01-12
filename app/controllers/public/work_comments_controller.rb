class Public::WorkCommentsController < ApplicationController
  
  def create
    @work = Work.find(params[:work_id])
    @comment = current_user.work_comments.new(work_comment_params)
    @comment.work_id = @work.id
    @comment.save
    # redirect_to work_path(@work)
  end

  def destroy
    comment = WorkComment.find(params[:id])
    @work = comment.work
    comment.destroy
    # redirect_to work_path(@work)
  end
  
  private
  
  def work_comment_params
    params.require(:work_comment).permit(:comment)
  end 
  
end
