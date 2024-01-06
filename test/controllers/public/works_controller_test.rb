require "test_helper"

class Public::WorksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_works_index_url
    assert_response :success
  end

  test "should get show" do
    get public_works_show_url
    assert_response :success
  end

  test "should get update" do
    get public_works_update_url
    assert_response :success
  end

  test "should get destroy" do
    get public_works_destroy_url
    assert_response :success
  end

  test "should get create" do
    get public_works_create_url
    assert_response :success
  end

  test "should get bookmarks" do
    get public_works_bookmarks_url
    assert_response :success
  end
end
