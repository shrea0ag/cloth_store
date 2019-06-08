require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  def setup
  	@borrowee = create(:borrowee)
  	@borrower = create(:borrower)
    @product  = create(:product, borrowee: @borrowee)
  	@order = create(:order, borrower: @borrower)
  	@order_item = create(:order_item, borrower: @borrower, product: @product, order:@order)
  end

  test "@order_item should be valid" do
  	assert @order_item.valid?
  end

  test "order_id should be present" do
  	@order_item.order_id = "  "
  	assert_not @order_item.valid?
  end

  test "size should be present" do
  	@order_item.size = " "
  	assert_not @order_item.valid?
  end


  test "borrower_id should be not be nil" do
  	@order_item.borrower_id = " "
  	assert_not @order_item.valid?
  end

  test "color should be present" do
  	@order_item.color = " "
  	assert_not @order_item.valid?
  end
end
