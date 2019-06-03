require 'test_helper'

class ProductsInterfaceTestTest < ActionDispatch::IntegrationTest
  def setup
		@borrowee = create(:borrowee)
		@product = create(:product, borrowee: @borrowee)
		@borrower = create(:borrower)
	end

	test "product interface" do  
		sign_in @borrowee
		get new_product_path
		assert_select 'input[type=submit]'
		assert_no_difference 'Product.count' do
      post products_path, params: { product: { borrowee_id: "" }}
    end
    assert_not flash.empty?
	end
end
