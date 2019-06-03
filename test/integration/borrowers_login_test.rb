require 'test_helper'

class BorrowersLoginTest < ActionDispatch::IntegrationTest
  def setup
		@borrower = create(:borrower)
	end

	test "login with invalid information" do  
		get new_borrower_session_path
		assert_template 'devise/sessions/new'
		post new_borrower_session_path, params: { borrower: { email: "", password: ""}}
		assert_template 'devise/sessions/new'
		assert_not flash.empty?
	end

	test "login with valid information" do  
		get new_borrower_session_path
		assert_template 'devise/sessions/new'
		post new_borrower_session_path, params:{ borrower: { email: "faa@gmail.com", password: "123456"},commit: "Log in"}
		assert_redirected_to '/'
		follow_redirect!
		get products_path
		assert_template 'products/index'
	end
end
