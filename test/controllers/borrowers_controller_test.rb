require 'test_helper'

class BorrowersControllerTest < ActionDispatch::IntegrationTest
  def setup
  	@borrower = create(:borrower)
  end

  test "should get new" do
  	get new_borrower_session_path
  	assert_response :success
	end

	test "can change password" do
		get edit_borrower_password_path(@borrower)
		assert_not flash.empty?
		assert_redirected_to new_borrower_session_path
	end

	test "cannot add product without login" do
		get products_path
		assert_not flash.empty?
		assert_redirected_to new_borrower_session_path
	end

	test 'cannot access borrowee show page without login' do
		get borrower_path(@borrower.id)
		assert_not flash.empty?
		assert_redirected_to new_borrower_session_path
	end

	test 'authenticated borrower can login and access layout links' do
    sign_in @borrower
    get '/products'
    assert_response :success
    assert_select "a[href=?]", products_path
    assert_select "a[href=?]", edit_borrower_registration_path
    assert_select "a[href=?]", borrower_path(@borrower.id)
    assert_select "a[href=?]", destroy_borrower_session_path
    assert_select "a[href=?]", borrowers_path
  end
end
