require "test_helper"

class Admin::ClubsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_clubs_show_url
    assert_response :success
  end

  test "should get index" do
    get admin_clubs_index_url
    assert_response :success
  end
end
