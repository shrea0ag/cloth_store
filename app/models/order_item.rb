class OrderItem < ApplicationRecord
  belongs_to :borrower
  belongs_to :product
  belongs_to :order
  before_save :total_of_a_order_item
	validates   :size, presence: true
	validates   :color, presence: true

  def total_of_a_order_item
		self.total = product.price 
	end
end
