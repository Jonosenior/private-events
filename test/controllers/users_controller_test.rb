require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:valid)
    @other_user = users(:hannah)
  end

  test "should get new if not logged in" do
    get new_user_url
    assert_response :success
  end

  test "should redirect from new if logged in" do
    log_in_as(@user)
    get new_user_url
    assert_redirected_to root_url
    refute flash.empty?
  end

end
