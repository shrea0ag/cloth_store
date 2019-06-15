class Product < ApplicationRecord
  belongs_to :borrowee
  has_many   :order_items, dependent: :destroy
  has_one_attached :image
	validates  :borrowee_id, presence: true
	validates  :name, presence: true, length: { in: 3..20 }
	validates  :price,  presence: true
  validates  :quantity, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates  :gender, presence: true
  validates  :color, presence: true
  validates  :image, presence: true
  validates  :borrowed_quantity, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}, on: [:update]
  validate  :one_of_the_sizes_must_be_checked


  def one_of_the_sizes_must_be_checked
    if [size_s,size_xs,size_m,size_l,size_xl].all? {|word| word.eql?(false)}
      errors.add(:base, "one size should be selected")
    end
  end

	def size 
		q = {s: size_s, xs: size_xs, m: size_m, l: size_l, xl: size_xl}
		q.select{|key, value| value.eql?(true) }.keys.join(',')
	end


  def available?
    quantity > 0
  end
end


