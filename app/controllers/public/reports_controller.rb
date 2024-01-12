class Public::ReportsController < ApplicationController
  def create
    report = Report.new(report_params)
    
    report.user_id = current_user.id
    report.work_id = params[:report][:which_work]
    if report.save
      redirect_to work_path(report.work_id), notice: "問題を報告しました。"
    else
      @work = Work.find(report.work_id)
      flash.now[:alert] = "報告内容を記入してください。"
      render :new
    end
  end

  def new
    @work = Work.find(params[:id])
  end

  def confirm
  end

  def accepted
  end
  
  private
  
  def report_params
    params.require(:report).permit(:type, :comment)
  end
end
