require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  def setup
  	@borrowee = create(:borrowee)
		@product = create(:product, borrowee: @borrowee)
		@borrower = create(:borrower)
  end

  test "product is valid" do
  	assert @product.valid?
  end

  test "borroweeid cant  be blank" do 
  	@product.borrowee_id = " "
  	assert_not @product.valid?
  end

  test "name cnt be blank" do  
  	@product.name = ' '
  	assert_not @product.valid?
  end

  test "price cnt be blank" do
  	@product.price = " "
  	assert_not @product.valid?
  end

  test "color must be choosen" do  
  	@product.color = " "
  	assert_not @product.valid?
  end

  test "one of the sizes must not be true" do  
  	@product.size_s = false
  	assert @product.valid?
  end

  test "gender must be choosen" do  
  	@product.gender = " "
  	assert_not @product.valid?
  end

end
