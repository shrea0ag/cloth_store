class OrderItem < ApplicationRecord
  belongs_to :borrower
  belongs_to :product
  belongs_to :order
  before_save :total_of_a_order_item
	validates   :size, presence: true
	validates   :color, presence: true
	validates   :quantity, presence: true, numericality: {only_integer: true, greater_than: 0}
	validate    :ordered_quantity_not_greater_than_product_quantity_present

  def total_of_a_order_item
		self.total = product.price * quantity
	end

	def ordered_quantity_not_greater_than_product_quantity_present
		if quantity > product.quantity
			errors.add(:base, "#{product.quantity} is available")
		end
	end
end
