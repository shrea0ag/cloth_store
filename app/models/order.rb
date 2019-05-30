class Order < ApplicationRecord

  belongs_to :borrower
  has_many :order_items, dependent: :destroy
  has_one  :payment
  before_update :days_to_expected_return_date
  before_update :update_status
  scope :open_orders, ->{ where(status: 'processing')}

  def total_of_a_order
    order_items.collect {|x| x.total}.sum * days
  end

  def days_to_expected_return_date
    self.expected_return_date = Date.today + days
  end

  def final_total_of_total
    total_price = 0
    order_items.each do |item| 
      total_price += (Date.today - expected_return_date) * (item.total + 200)
    end
    total_price
  end


  def total_amount
    if Date.today == expected_return_date
      self.total = total_of_a_order
    else
      self.total = final_total_of_total
    end
  end
  
  private
  def update_status
    if status == "processing"
      self.status = "borrowed"
    end
  end
end



# if Date.today < expected_return_date
#           total_price += item.total