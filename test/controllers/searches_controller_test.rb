require 'test_helper'

class SearchesControllerTest < ActionDispatch::IntegrationTest
  def setup
  	@borrowee = create(:borrowee)
  	@borrower = create(:borrower)
  	@product = create(:product)
  	@search = create(:search)
  end

  test "borrowee cannot access filters" do
  	sign_in @borrowee
  	get new_search_path
  	assert_redirected_to new_borrower_session_path
  end

  test "borrower can access filters" do
  	sign_in @borrower
  	get new_search_path
  	assert_response :success
  end

  test "borrower can create filter" do
  	sign_in @borrower
  	post searches_path, params: {search: {keywords: "round-kurti", min_price: 700, gender: "Female", max_price: 700}, commit: "search"} 
  	follow_redirect!
  end
end
