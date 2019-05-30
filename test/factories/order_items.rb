FactoryBot.define do
  factory :order_item do
    size { "MyString" }
    color { "MyString" }
    quantity { 1 }
    total { "9.99" }
    borrower { nil }
    product { nil }
  end
end
