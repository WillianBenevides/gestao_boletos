require "test_helper"

class BoletosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get boletos_index_url
    assert_response :success
  end

  test "should get show" do
    get boletos_show_url
    assert_response :success
  end

  test "should get new" do
    get boletos_new_url
    assert_response :success
  end

  test "should get create" do
    get boletos_create_url
    assert_response :success
  end

  test "should get edit" do
    get boletos_edit_url
    assert_response :success
  end

  test "should get update" do
    get boletos_update_url
    assert_response :success
  end

  test "should get destroy" do
    get boletos_destroy_url
    assert_response :success
  end
end
