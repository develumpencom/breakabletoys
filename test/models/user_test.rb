require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "should validate user" do
    assert @user.valid?
  end

  test "should not validate user without email" do
    @user.email_address = nil

    assert_not @user.valid?
    assert_not_nil @user.errors[:email_address]
  end

  test "should not validate user without password" do
    @user.password = nil

    assert_not @user.valid?
    assert_not_nil @user.errors[:password]
  end
end
