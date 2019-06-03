require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
	def setup
		@borrower = create(:borrower)
		@order = create(:order, borrower: @borrower)
		@payment = create(:payment, order: @order)
	end

	test "payemnt is valid" do
		assert @payment.valid?
 	end

 	test "token must be present" do  
 		@payment.token =  " "
 		assert_not @payment.valid?
 	end

 	test "transaction_id must be present" do  
 		@payment.transaction_id =  " "
 		assert_not @payment.valid?
 	end

 	test "order_id must be present" do  
 		@payment.order_id =  " "
 		assert_not @payment.valid?
 	end

 	test "payment must be present" do  
 		@payment.amount =  " "
 		assert_not @payment.valid?
 	end
end
# :token, :transaction_id, :order_id, :amount,