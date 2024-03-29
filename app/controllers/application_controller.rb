class ApplicationController < ActionController::Base
  
  before_action :authenticate_admin!, if: :admin_area?
  
  private
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_reports_path
    when User
      my_page_user_path(current_user)
    end
  end

  def after_sign_out_path_for(resource)
    case resource
    when :admin
      new_admin_session_path
    when :user
      root_path
    end
  end
  
  def admin_area?
    request.fullpath.include?("/admin") && !request.fullpath.include?("/admin/sign_in")
  end
  
end
