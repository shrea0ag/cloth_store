require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get '/'
    assert_response :success
  end

  test "should get borrowees sign_in" do
  	get new_borrowee_session_path
  	assert_response :success
  end

  test "should get borrower sign_in" do
  	get new_borrower_session_path
  	assert_response :success
  end


end
