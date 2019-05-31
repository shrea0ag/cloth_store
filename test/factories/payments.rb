FactoryBot.define do
  factory :payment do
    amount { "9.99" }
    token { "MyString" }
    transaction_id { "MyString" }
    order_id { 1 }
  end
end
