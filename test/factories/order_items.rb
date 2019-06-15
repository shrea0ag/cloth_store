FactoryBot.define do
  factory :order_item do
    size { "size_xs" }
    color { "white" }
    total { 0.5e3 }
    quantity {2}
    borrower_id { 3 }
    product_id { 10 }
    order_id { 18 }
  end
end
