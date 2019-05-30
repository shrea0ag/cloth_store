require 'test_helper'

class BorroweesControllerTest < ActionDispatch::IntegrationTest
	
	include Devise::Test::IntegrationHelpers

  def setup
  	@borrowee = create(:borrowee)
 
  end

  test "should get new" do
  	get new_borrowee_session_path
  	assert_response :success
	end

	test "can change password" do
		get edit_borrowee_password_path(@borrowee)
		assert_not flash.empty?
		assert_redirected_to new_borrowee_session_path
	end

	test "cannot add product without login" do
		get new_product_path
		assert_not flash.empty?
		assert_redirected_to new_borrowee_session_path
	end

	test 'cannot access borrowee show page without login' do
		get borrowee_path(@borrowee.id)
		assert_not flash.empty?
		assert_redirected_to new_borrowee_session_path
	end

	test 'authenticated users can GET index' do
    sign_in @borrowee
    get '/products/new'
    assert_response :success
    assert_select "a[href=?]", new_product_path
    assert_select "a[href=?]", edit_borrowee_registration_path
    assert_select "a[href=?]", borrowee_path(@borrowee.id)
    assert_select "a[href=?]", destroy_borrowee_session_path
  end


end
