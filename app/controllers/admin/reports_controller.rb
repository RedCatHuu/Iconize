class Admin::ReportsController < ApplicationController
  
  def index
    @reports = Report.all
  end 
  
  def show
    @report = Report.find(params[:id])
    @user = @report.user
    @work = @report.work
  end

  def update
    report = Report.find(params[:id])
    if report.update(report_params)
      flash[:notice] = "フラグを変更しました。"
      redirect_to admin_report_path(report)
    else
      flash.now[:alert] = "フラグの変更に失敗しました。"
      @report = report
      render :show
    end 
  end
  
  private
  
  def report_params
    params.require(:report).permit(:status)
  end
  
end
