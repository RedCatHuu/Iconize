require "test_helper"

class Admin::ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_reports_show_url
    assert_response :success
  end

  test "should get update" do
    get admin_reports_update_url
    assert_response :success
  end
end
