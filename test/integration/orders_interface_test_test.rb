require 'test_helper'

class OrdersInterfaceTestTest < ActionDispatch::IntegrationTest
  def setup
		@borrowee = create(:borrowee)
  	@borrower = create(:borrower)
    @product  = create(:product, borrowee: @borrowee)
  	@order = create(:order, borrower: @borrower)
  	@order_item = create(:order_item, borrower: @borrower, product: @product, order:@order)
	end

	test "order interface" do  
		sign_in @borrowee
  	get orders_path
  	assert_redirected_to new_borrower_session_path
  	assert_not flash.empty?
  	sign_in @borrower
  	get products_path
  	assert_select "a"
  	get product_path(@product)
  	post order_items_path, params: { order_item: {product_id: @product.id, size: "m", quantity: 1, color: "white"}, commit: "Create Order item"}
    assert_redirected_to borrower_path(@borrower)
   	get edit_order_path(@order)
    assert_response :success
	end
end
