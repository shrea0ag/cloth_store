FactoryBot.define do
  factory :order_item do
    size { "size_xs" }
    color { "white" }
    quantity { 1 }
    total { 0.5e3 }
    borrower_id { 5 }
    product_id { 1 }
    order_id { 7 }
  end
end
