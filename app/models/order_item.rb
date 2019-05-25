class OrderItem < ApplicationRecord
  belongs_to :borrower
  belongs_to :product
  has_one    :order

  attr_accessor :days
 	before_save :days_to_return_date
  

  def days_to_return_date
  	self.expected_return_date = Date.today + days.to_i
	end
end
