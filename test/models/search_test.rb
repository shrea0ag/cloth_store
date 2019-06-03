require 'test_helper'

class SearchTest < ActiveSupport::TestCase
 def setup
  	@borrowee = create(:borrowee)
  	@borrower = create(:borrower)
  	@product = create(:product)
  	@search = create(:search)
  end


  test "search is valid" do
  	@search.valid?
	end

	test "any of the value must be choose" do
		@search.keywords = " "
		@search.min_price = nil
		@search.max_price = nil
		@search.gender = "Male"
		assert @search.valid?
	end


	test "keywords cn be blank" do  
		@search.keywords = " "
		assert @search.valid?
	end

	test "gender can be blnk" do
		@search.gender = " "
		assert @search.valid?
	end

	test "min_price can be blank" do  
		@search.min_price = nil
		assert @search.valid?
	end
end
