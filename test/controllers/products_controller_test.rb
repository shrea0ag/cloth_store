require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest

	include Devise::Test::IntegrationHelpers

	def setup
		@borrowee = create(:borrowee)
		@product = create(:product, borrowee: @borrowee)
		@borrower = create(:borrower)
	end

	test "authenticated borrowee can login and access product links" do
		sign_in @borrowee
		get '/products/new'
    assert_response :success
    assert_select "a[href=?]", new_product_path
    assert_select "a[href=?]", edit_borrowee_registration_path
    assert_select "a[href=?]", borrowee_path(@borrowee.id)
    assert_select "a[href=?]", destroy_borrowee_session_path
	end

	test "authenticated borrower can login and access product links" do
		sign_in @borrower
    get '/products'
    assert_response :success
    assert_select "a[href=?]", products_path
    assert_select "a[href=?]", edit_borrower_registration_path
    assert_select "a[href=?]", borrower_path(@borrower.id)
    assert_select "a[href=?]", destroy_borrower_session_path
    assert_select "a[href=?]", borrowers_path
	end

	test "borrower can't add products" do
		sign_in @borrower
		get '/products/new'
		assert_redirected_to new_borrowee_session_path
	end

	test "borrower can't edit added product" do
		sign_in @borrower
		get edit_product_path(@product)
		assert_redirected_to new_borrowee_session_path
	end

	test "borrower can't delete added product" do
		sign_in @borrower
		delete product_path(@product)
		assert_redirected_to new_borrowee_session_path
	end

	test "borrowee can't see all products" do
		sign_in @borrowee
		get products_path
		assert_redirected_to new_borrower_session_path
	end
end