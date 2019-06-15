require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
	def setup
		@borrowee = create(:borrowee)
  	@borrower = create(:borrower)
    @product  = create(:product, borrowee: @borrowee)
  	@order = create(:order, borrower: @borrower)
  	@order_item = create(:order_item, borrower: @borrower, product: @product, order:@order)
	end

	test "borrowee should redirect to login" do
  	sign_in @borrowee
  	get orders_path
  	assert_redirected_to new_borrower_session_path
  end

  test "borrower can place order without adding to cart" do
    sign_in @borrower
    get products_path
    assert_response :success
    get product_path(@product)
    assert_response :success
    post order_items_path, params: { order_item: {product_id: @product.id, size: "m", color: "white"}, commit: "Create Order item"}
    follow_redirect!
    assert_response :success
    get edit_order_path(@order)
    assert_response :success
    patch order_path, params: {order: {address: "b-80,bajaj nagar", phone: "7877748711", days: 2}}
    assert_redirected_to borrowers_path
  end

  test "borrower can place order from to cart" do
    sign_in @borrower
    get products_path
    assert_response :success
    get product_path(@product)
    assert_response :success
    post order_items_path, params: { order_item: {product_id: @product.id, size: "m", color: "white"}, commit: "Add to cart"}
    follow_redirect!
    assert_response :success
    get edit_order_path(@order)
    assert_response :success
    patch order_path, params: {order: {address: "b-80,bajaj nagar", phone: "7877748711", days: 2}}
    assert_redirected_to borrowers_path
  end

  test "borrower can see the bill before returning" do
  	sign_in @borrower
    get products_path
    assert_response :success
    get product_path(@product)
    assert_response :success
    post order_items_path, params: { order_item: {product_id: @product.id, size: "m",  color: "white"}, commit: "Create Order item"}
    follow_redirect!
    assert_response :success
    get edit_order_path(@order)
    assert_response :success
    patch order_path, params: {order: {address: "b-80,bajaj nagar", phone: "7877748711", days: 2, name: 'Faa', pincode: 302015, city: 'jaipur'}}
    get borrowers_path
    assert_response :success
  end
end
