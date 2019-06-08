require 'test_helper'

class OrderItemsInterfaceTestTest < ActionDispatch::IntegrationTest
  def setup
  	@borrowee = create(:borrowee)
  	@borrower = create(:borrower)
    @product  = create(:product, borrowee: @borrowee)
  	@order = create(:order, borrower: @borrower)
  	@order_item = create(:order_item, borrower: @borrower, product: @product, order:@order)
  end

  test "orderitem interface" do  
  	sign_in @borrowee
  	get products_path
  	assert_redirected_to new_borrower_session_path
  	assert_not flash.empty?
  	sign_in @borrower
  	get products_path
  	assert_response  :success
  	get product_path(@product)
  	assert_template 'products/show'
  	assert_no_difference 'OrderItem.count' do
  		post order_items_path, params: { order_item: {product_id: @product.id, size: "", quantity: 1, color: ""}, commit: "Create Order item"}
  	end
  	assert_redirected_to products_path
  	assert_not flash.empty?
  	assert_difference 'OrderItem.count', 1 do
  		post order_items_path, params: { order_item: {product_id: @product.id, size: "m", quantity: 1, color: "white"}, commit: "Create Order item"}
  	end
  	follow_redirect!
  	assert_template 'borrowers/show'
  	assert_not flash.empty?
  	assert_select 'a', text: 'delete', count: 0
  end

  test "orderitem interface with cart" do
  	sign_in @borrowee
  	get products_path
  	assert_redirected_to new_borrower_session_path
  	assert_not flash.empty?
  	sign_in @borrower
  	get products_path
  	assert_response  :success
  	get product_path(@product)
  	assert_template 'products/show'
  	assert_no_difference 'OrderItem.count' do
  		post order_items_path, params: { order_item: {product_id: @product.id, size: "", quantity: 1, color: ""}, commit: "Add to cart"}
  	end
  	assert_redirected_to products_path
  	assert_not flash.empty?
  	assert_difference 'OrderItem.count', 1 do
  		post  order_items_path, params: { order_item: {product_id: @product.id, size: "m", quantity: 1, color: "white"}, cart: "Add to cart"}
  	end
  	follow_redirect!
  	assert_template 'borrowers/show'
  	assert_not flash.empty?
  	assert_select "a", text: 'delete', count: 0
  	assert_template 'borrowers/show'
  end
end
