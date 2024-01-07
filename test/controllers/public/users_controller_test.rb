require "test_helper"

class Public::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_users_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_users_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_users_update_url
    assert_response :success
  end

  test "should get confirm" do
    get public_users_confirm_url
    assert_response :success
  end

  test "should get exit" do
    get public_users_exit_url
    assert_response :success
  end

  test "should get following" do
    get public_users_following_url
    assert_response :success
  end

  test "should get followers" do
    get public_users_followers_url
    assert_response :success
  end
end
