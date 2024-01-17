require "test_helper"

class Admin::WorksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_works_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_works_show_url
    assert_response :success
  end

  test "should get update" do
    get admin_works_update_url
    assert_response :success
  end

  test "should get confirm" do
    get admin_works_confirm_url
    assert_response :success
  end
end
