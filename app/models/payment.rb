class Payment < ApplicationRecord
  belongs_to :order
  validates  :token, :transaction_id, :order_id, :amount, presence:true
end
