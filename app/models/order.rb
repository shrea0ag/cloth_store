class Order < ApplicationRecord
  belongs_to :borrower
  has_many :order_items, dependent: :destroy
  has_one  :payment
  before_update :days_to_expected_return_date
  before_update :update_status
  validates  :status, presence: true
  validates  :days, numericality: {less_than: 5}, allow_blank: true
  validates  :address, length: { maximum: 50 }, allow_blank: true
  validates  :phone, numericality: true, length: {is: 10}, allow_blank: true
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
      sum_total_of_order_items * (Date.today - updated_at.to_date)
    end
  end

  def total_of_late_return_order
    total_price = 0
    order_items.each do |item| 
      total_price += (Date.today - expected_return_date) * (item.total + 200)
    end
    total_price
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
  
  private
  def update_status
    if status == 'processing'
      self.status = "borrowed"
    end
  end

  def sum_total_of_order_items
    order_items.collect {|x| x.total }.sum
  end
end



