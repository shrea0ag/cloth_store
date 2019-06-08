FactoryBot.define do
  factory :payment do
    amount { 300 }
    token { "tokencc_bh_n87gcv_5cnz6s_59hs3w_ccryp7_9n5" }
    transaction_id { "hk9b1yvw" }
    order_id { 7 }
  end
end
