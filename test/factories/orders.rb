FactoryBot.define do
  factory :order do
    actual_return_date { "2019-05-30" }
    status { "MyString" }
    total { "9.99" }
    address { "MyString" }
    phone { "MyString" }
    expected_return_date { "2019-05-30" }
    days { 1 }
    borrower { nil }
  end
end
