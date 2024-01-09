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
  end
end
