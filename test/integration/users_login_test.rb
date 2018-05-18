require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:valid)
  end

  test "login with invalid information" do
    get login_path
    assert_select "form[action=?]", login_path
    post login_path, params: { session: { email: "invalid",
                                          password: "no" }}
    refute is_logged_in?
    refute flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: "donuts"}}
    assert is_logged_in?
    refute flash.empty?
    follow_redirect!
    assert_select "div#flash", "Welcome back, #{@user.name}!"
    assert_select "a[href=?]", login_url, count: 0
    assert_select "a[href=?]", new_user_url, count: 0
    assert_select "a[href=?]", logout_url
    assert_select "a[href=?]", new_event_url
    get logout_path
    refute flash.empty?
    follow_redirect!
    refute is_logged_in?
    assert_select "a[href=?]", logout_url, count: 0
    assert_select "a[href=?]", new_event_url, count: 0
    assert_select "a[href=?]", login_url
    assert_select "a[href=?]", new_user_url
  end
end
