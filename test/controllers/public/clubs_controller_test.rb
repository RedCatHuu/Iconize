require "test_helper"

class Public::ClubsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_clubs_create_url
    assert_response :success
  end

  test "should get new" do
    get public_clubs_new_url
    assert_response :success
  end

  test "should get index" do
    get public_clubs_index_url
    assert_response :success
  end

  test "should get show" do
    get public_clubs_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_clubs_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_clubs_update_url
    assert_response :success
  end

  test "should get myclub" do
    get public_clubs_myclub_url
    assert_response :success
  end
end
