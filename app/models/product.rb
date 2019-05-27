class Product < ApplicationRecord
  belongs_to :borrowee
  has_many   :order_items
  has_one_attached :image
	validates  :borrowee_id, presence: true
	validates  :name, presence: true, length: { in: 4..20 }
	validates  :price, :count, presence: true, numericality: true
  validates  :gender, presence: true

	def size 
		#Product.column_names.select{|i| i[("size")]}
		q = {s: size_s, xs: size_xs, m: size_m, l: size_l, xl: size_xl}
		q.select{|key, value| value.eql?(true) }.keys.join(',')
	end

  def available?
    if count_quantity_of_product_borrowed > 0
      "true"
    end
  end

  private
	def count_quantity_of_product_borrowed
  	self.count -  self.order_items.ids.collect {|x| Order.find_by_order_item_id(x).status}.count("borrowed")
  end


 

end


# def thumbnail input
  #   return self.images[input].variant(resize: "300x300!").processed
  # end