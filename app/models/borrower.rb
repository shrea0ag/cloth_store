class Borrower < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders
  has_many :order_items
  validates :name,  presence: true, length: { maximum: 50 }
 	validates :email, presence: true, uniqueness: true
  validates :phone, presence: true, numericality: true, length: {is: 10}, uniqueness: true


  def items_in_cart?
    order_items_having_status_processing > 0
  end

  def processing_orders
    orders.open_orders
  end

  def borrowed_orders
    orders.where(status: "borrowed")
  end

  def open_order
    orders.open_orders.take || orders.create
  end
  
  def order_items_having_status_processing
    order_items.includes(:order).select {|x| x.order.status.eql?("processing")}.count
  end
end
