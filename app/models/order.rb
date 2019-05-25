class Order < ApplicationRecord
  belongs_to :borrower
  belongs_to :order_item
  before_create :initial_total
  before_update :update_total
  before_save :update_status


  def calculate_initial_total
    item = self.order_item  
    self.total = item.product.price * item.quantity * (item.expected_return_date - Date.today) 
  end
  
  def calculate_final_total
     item = self.order_item  
    self.total = total + (actual_return_date - item.expected_return_date) * (item.product.price + 200)
  end


  private
  def initial_total
  	self.total = calculate_initial_total
  end

  def update_total
    self.total = calculate_final_total
  end

  def update_status
    if self.status.eql?("processing")
      self.status = "borrowed"
    else 
      self.status = "returned"
    end
  end
end
