class Admin::WorksController < ApplicationController
  def index
    @opend_works = Work.where(is_published: true).order(created_at: :desc).page(params[:page]).per(24)
    @closed_works = Work.where(is_published: false).order(created_at: :desc).page(params[:page]).per(24)
  end

  def show
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id])
    status = @work.is_published? ? false : true
    if @work.update(is_published: status)
      flash[:notice] = "公開ステータスを更新しました。"
      redirect_to admin_work_path(@work)
    else
      flash.now[:alert] = "公開ステータスの更新に失敗しました。"
      render :show
    end 
  end
  
  def destroy
    work = Work.find(params[:id])
    work.destroy
    redirect_to admin_works_path, notice: "作品を削除しました。"
  end 
  
  def confirm
    @work = Work.find(params[:id])
    @way = params[:way]
    case @way
    when "validate"
      @way_ja = "公開"
    when "invalidate"
      @way_ja = "非公開に"
    when "destroy"
      @way_ja = "削除"
    end 
  end
  
  private
  
  def work_params
    params.require(:work).permit(:is_published)
  end 
  
end
