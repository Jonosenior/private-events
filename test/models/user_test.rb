require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:valid)
  end

  test 'valid user' do
    assert @user.valid?
  end

  test 'email should be present' do
    @user.email = "   "
    refute @user.valid?
  end

  test 'name should be present' do
    @user.name = "   "
    refute @user.valid?
  end

  test 'password should not be too short' do
    @user = User.new(name: "Tim", email: "tim@tim.com", password: 'yo', password_confirmation: 'yo')
    refute @user.valid?
  end



end
