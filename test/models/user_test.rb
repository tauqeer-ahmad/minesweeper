
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should be valid" do
    user = User.new(email: 'test@example.com')
    assert user.valid?
  end

  test "should be invalid without email" do
    user = User.new(email: nil)
    assert_not user.valid?
  end

  test "should not allow duplicate emails" do
    user1 = User.create(email: 'test@example.com')
    user2 = User.new(email: 'test@example.com')
    assert_not user2.valid?
  end
end
