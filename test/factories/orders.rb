FactoryBot.define do
  factory :order do
    actual_return_date { "2019-05-30" }
    status { "processing" }
    total { "9.99" }
    address { "b-80" }
    phone { "9829034774" }
    name  {'Faa'}
    city  {'Jaipur'}
    pincode {302015}
    expected_return_date { "2019-05-30" }
    days { 1 }
    borrower_id { 3 }
  end
end
