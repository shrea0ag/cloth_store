FactoryBot.define do
  factory :product do
  	borrowee_id {3}
    name { "John" }
    size_xs {true }
	  size_s { false }
	  size_m { true }
	  size_l { true }
	  size_xl { false }
	  price { 0.5e3 }
	  color { "white,blue" }
	  quantity { 40 }
	  gender { "Male" }
	  borrowed_quantity{0}
    image { Rack::Test::UploadedFile.new('test/fixtures/boy1.jpeg', 'image/jpeg')}
  end
end