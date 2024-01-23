class Admin::WorksController < ApplicationController
  def index
    @works = Work.page(params[:page]).per(24)
  end

  def show
    @work = Work.find(params[:id])
  end

  def update
    work = Work.find(params[:id])
    if work.update(work_params)
      flash[:notice] = "公開ステータスを変更しました。"
      redirect_to admin_work_path(work)
    end
  end
  
  private
  
  def work_params
    params.require(:work).permit(:is_published)
  end 
  
end
