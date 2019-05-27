require 'test_helper'

class BorroweeTest < ActiveSupport::TestCase

	def setup
		@borrowee = Borrowee.new(name: "abhilasha", phone: 9829034774, email: "abhi@gmail.com", password: "123456")
	end

  test "@borrowee should be valid" do
  	assert @borrowee.valid?
  end

  test "name should be present" do
  	@borrowee.name = "   "
  	assert_not @borrowee.valid?
  end

  test "email should be present" do
  	@borrowee.email = "   "
  	assert_not @borrowee.valid?
  end

  test "password should be present" do
  	@borrowee.password = "  "
  	assert_not @borrowee.valid?
  end

  test "phone number should be present" do
  	@borrowee.phone = nil
  	assert_not @borrowee.valid?
  end

  test "phone number length should be 10" do
  	@borrowee.phone = 9829034774
  	assert @borrowee.valid?
  end

  test "phone should be unique" do
  	dup_user = @borrowee.dup 
  	@borrowee.save
  	assert_not dup_user.valid?
  end

  test "email add should be unique" do
  	dup_user = @borrowee.dup
  	dup_user.email = @borrowee.email.upcase
  	@borrowee.save
  	assert_not dup_user.valid?
  end
end
