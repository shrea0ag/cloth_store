require 'test_helper'

class OrderTest < ActiveSupport::TestCase
 	def setup
		@borrowee = create(:borrowee)
  	@borrower = create(:borrower)
    @product  = create(:product, borrowee: @borrowee)
  	@order = create(:order, borrower: @borrower)
  	@order_item = create(:order_item, borrower: @borrower, product: @product, order:@order)
	end

	test "@order should be valid" do
  	assert @order.valid?
  end

  test "days must less than 5" do
  	@order.days = 6
  	assert_not @order.valid?
  end

  test "phone length must be 10" do
  	@order.phone = "98290347742"
  	assert_not @order.valid?
  end

  test "status can't be blank" do
  	@order.status = "  "
  	assert_not @order.valid?
  end

  test "borrower should be present" do 
  	@order.borrower_id = " "
  	assert_not @order.valid?
  end
end
