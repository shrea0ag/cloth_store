require 'test_helper'

class OrderItemsControllerTest < ActionDispatch::IntegrationTest
  def setup
  	@borrowee = create(:borrowee)
  	@borrower = create(:borrower)
    @product  = create(:product)
  	@order = create(:order, borrower: @borrower)
  	@order_item = create(:order_item, borrower: @borrower, product: @product, order:@order)
  end

  test "borrowee should redirect to login" do
  	sign_in @borrowee
  	get edit_order_item_path(@order_item)
  	assert_redirected_to new_borrower_session_path
  end

  test "borrower can add order_item to cart" do
    sign_in @borrower
    get products_path
    assert_response :success
    get product_path(@product)
    assert_response :success
    post  order_items_path, params: { order_item: {product_id: @product.id, size: "m", quantity: 1, color: "white"}, cart: "Add to cart"}
    assert_redirected_to borrower_path(@borrower)
    follow_redirect!
    assert_response :success
  end

  test "borrower can place order without adding to cart" do
    sign_in @borrower
    get products_path
    assert_response :success
    get product_path(@product)
    assert_response :success
    post order_items_path, params: { order_item: {product_id: @product.id, size: "m", quantity: 1, color: "white"}, commit: "Create Order item"}
    follow_redirect!
    assert_response :success
  end

  test "borrower can't create orderitem without login" do
    post order_items_path
    assert_redirected_to new_borrower_session_path
  end

  test "borrower can edit orderitem when added to cart" do
    sign_in @borrower
    get products_path
    assert_response :success
    get product_path(@product)
    assert_response :success
    post  order_items_path, params: { order_item: {product_id: @product.id, size: "m", quantity: 1, color: "white"}, cart: "Add to cart"}
    assert_redirected_to borrower_path(@borrower)
    follow_redirect!
    assert_response :success
    get edit_order_item_path
    assert_response :success
    patch order_item_path, params: {order_item: {quantity: 1, size: "xs", color: "white"}}
    assert_redirected_to borrower_path(@borrower)
    follow_redirect!
    assert_response :success
  end
end
