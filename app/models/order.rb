class Order < ApplicationRecord
  belongs_to :borrower
  has_many :order_items, dependent: :destroy
  has_one  :payment
  before_update :days_to_expected_return_date
  before_update :update_status
  after_update :update_borrowed_product_quantity
  after_update :update_returned_product_quantity
  validates  :status, presence: true
  validates  :days, numericality: {less_than: 5}, allow_blank: true
  validates  :address, length: { maximum: 50 }, allow_blank: true
  validates  :phone, numericality: true, length: {is: 10}, allow_blank: true
  validates  :pincode, numericality: true, allow_blank: true
  validates_format_of :city, :with => /\A[a-z]+\z/i, allow_blank: true
  scope :open_orders, ->{ where(status: 'processing')}
  scope :closed_orders, ->{ where(status: 'returned')}
  
  def days_to_expected_return_date
    self.expected_return_date = Date.today + days
  end

  def total_of_a_order
    sum_total_of_order_items * days
  end

  def total_of_order_before_return_date
    if Date.today.eql?(updated_at.to_date)
      sum_total_of_order_items
    else
      sum_total_of_order_items * days_for_early_return_date
    end
  end

  def total_of_late_return_order
    days_for_late_return_date * sum_total_of_order_items + (number_of_order_items_in_a_order * 200) 
  end


  def total_amount
    if Date.today.eql?(expected_return_date) 
      self.total = total_of_a_order
    elsif Date.today < expected_return_date
      self.total = total_of_order_before_return_date
    else
      self.total = total_of_late_return_of_order
    end
  end

  def update_borrowed_product_quantity
    if status == "borrowed"
      order_items.map do |x|
        left = x.product.quantity - x.quantity
        x.product.update_attributes(quantity: left)
      end
    end
  end

  def update_returned_product_quantity
    if status == "returned"
      order_items.map do |x|
        left = x.product.quantity + x.quantity
        x.product.update_attributes(quantity: left)
      end
    end
  end

  
  private
  def update_status
    if status == 'processing'
      self.status = "borrowed"
    end
  end

  def sum_total_of_order_items
    order_items.collect {|x| x.total }.sum
  end

  def number_of_order_items_in_a_order
    order_items.count
  end

  def days_for_late_return_date
    Date.today - expected_return_date
  end

  def days_for_early_return_date
    Date.today - updated_at.to_date
  end
end



