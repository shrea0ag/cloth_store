class Product < ApplicationRecord
  belongs_to :borrowee
  has_many   :order_items
	validates  :borrowee_id, presence: true
	validates  :name, presence: true, length: { in: 6..20 }
	# validates  :size, presence: true
	validates  :price, presence: true, numericality: true

	def size 
		#Product.column_names.select{|i| i[("size")]}
		q = {s: size_s, xs: size_xs, m: size_m, l: size_l, xl: size_xl}
		q.select{|key, value| value.eql?(true) }.keys.join(',')
	end

	def count_quantity_of_product_borrowed
  	self.count - OrderItem.where("product_id = ?", self.id).count
  end

  def available?
  	if count_quantity_of_product_borrowed > 0
  		"true"
  	end
  end

end
