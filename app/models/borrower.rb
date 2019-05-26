class Borrower < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders
  has_many :order_items

  def borrowed_products
  	self.orders.where("status LIKE ?", "borrowed")
  end
end
