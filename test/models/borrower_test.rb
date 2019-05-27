require 'test_helper'

class BorrowerTest < ActiveSupport::TestCase

 	def setup
 		@borrower = Borrower.new(name: "shipra", email: "shipra@gmail.com", phone: "9829034774", password: "123456")
 	end

 	test "@borrower should be valid" do
  	assert @borrower.valid?
  end

  test "name should be present" do
  	@borrower.name = "   "
  	assert_not @borrower.valid?
  end

  test "email should be present" do
  	@borrower.email = "   "
  	assert_not @borrower.valid?
  end

  test "password should be present" do
  	@borrower.password = "  "
  	assert_not @borrower.valid?
  end

  test "phone number should be present" do
  	@borrower.phone = nil
  	assert_not @borrower.valid?
  end

  test "phone number length should be 10" do
  	@borrower.phone = 9829034774
  	assert @borrower.valid?
  end

  test "phone should be unique" do
  	dup_user = @borrower.dup 
  	@borrower.save
  	assert_not dup_user.valid?
  end

  test "email add should be unique" do
  	dup_user = @borrower.dup
  	dup_user.email = @borrower.email.upcase
  	@borrower.save
  	assert_not dup_user.valid?
  end
end
