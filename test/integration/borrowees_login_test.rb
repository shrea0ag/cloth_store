require 'test_helper'

class BorroweesLoginTest < ActionDispatch::IntegrationTest
	def setup
		@borrowee = create(:borrowee)
	end

	test "login with invalid information" do  
		get new_borrowee_session_path
		assert_template 'devise/sessions/new'
		post new_borrowee_session_path, params: { borrowee: { email: "", password: ""}}
		assert_template 'devise/sessions/new'
		assert_not flash.empty?
	end

	test "login with valid information" do  
		get new_borrowee_session_path
		assert_template 'devise/sessions/new'
		post new_borrowee_session_path, params:{ borrowee: { email: "priya@gmail.com", password: "123456"},commit: "Log in"}
		assert_redirected_to '/'
		follow_redirect!
		get new_product_path
		assert_template 'products/new'
	end
end
