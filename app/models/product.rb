class Product < ApplicationRecord
  belongs_to :borrowee
  has_many   :order_items, dependent: :destroy
  has_one_attached :image
	validates  :borrowee_id, presence: true
	validates  :name, presence: true, length: { in: 4..20 }
	validates  :price, :count, presence: true, numericality: true
  validates  :gender, presence: true
  validates  :color, presence: true
  validates  :image, presence: true
  validate  :one_of_the_sizes_must_be_checked


  def one_of_the_sizes_must_be_checked
    if [size_s,size_xs,size_m,size_l,size_xl].all? {|word| word.eql?(false)}
      errors.add(:base, "one size should be selected")
    end
  end

  def image_type
    if image.presence == false
      errors.add(:image, "should be attached")
    end
    if !image.content_type.in?(%('image/jpeg image/png image/jpg'))
      errors.add(:image, "needs to be JPEG,JPG or PNG")
    end
  end

	def size 
		q = {s: size_s, xs: size_xs, m: size_m, l: size_l, xl: size_xl}
		q.select{|key, value| value.eql?(true) }.keys.join(',')
	end

  def orders_for_a_product
    order_items.includes(:order)
  end

  def available?
    if count > count_quantity_of_product_borrowed  
      "true"
    end
  end

  private
  def count_quantity_of_product_borrowed
    orders_for_a_product.select {|x| x.order.status.eql?("borrowed")}.count
  end
end


