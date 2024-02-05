class Public::WorkCommentsController < ApplicationController
  
  def create
    @work = Work.find(params[:work_id])
    @comment = current_user.work_comments.new(work_comment_params)
    @comment.work_id = @work.id
    @comment.save
    @comments = WorkComment.where(work_id: @work.id).page(params[:page]).per(100)
  end

  def destroy
    comment = WorkComment.find(params[:id])
    # 他ユーザーのコメント削除防止
    unless comment.user_id == current_user.id
      return redirect_to work_path(comment.work)
    end
    @work = comment.work
    comment.destroy
    @comments = WorkComment.where(work_id: @work.id).page(params[:page]).per(100)
  end
  
  private
  
  def work_comment_params
    params.require(:work_comment).permit(:comment)
  end 
  
end
