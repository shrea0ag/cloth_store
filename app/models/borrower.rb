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

  def processing_orders
  	orders.where("status LIKE ?", "processing")
  end

  def borrowed_orders
    orders.where("status LIKE ?", "borrowed")
  end

  def open_order
    orders.open_orders.take || orders.create
  end
end
