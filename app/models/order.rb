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

  def total_of_a_order
    order_items.collect {|x| x.total}.sum * days
  end

  def days_to_expected_return_date
    self.expected_return_date = Date.today + days
  end

  def final_total_of_order
    total_price = 0
    order_items.each do |item| 
      total_price += (Date.today - expected_return_date) * (item.total + 200)
    end
    (total_price).abs
  end


  def total_amount
    if Date.today <= expected_return_date 
      self.total = total_of_a_order
    else
      self.total = final_total_of_order
    end
  end
  
  private
  def update_status
    if status == "processing"
      self.status = "borrowed"
    end
  end
end



