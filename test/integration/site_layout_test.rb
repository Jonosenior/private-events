require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest


  test "layout links as not logged in" do
    get root_path
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", login_url
    assert_select "a[href=?]", new_user_url
    assert_select "a[href=?]", new_event_url, false, "Non-logged-in users should not see a new event link"
    assert_select "a[href=?]", logout_url, false, "Non-logged-in users should not see a logout link"

  end

  test "layout links as logged in" do
    @user = users(:valid)
    log_in_as(@user)
    get root_path
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", new_event_url
    assert_select "a[href=?]", logout_url
    assert_select "a[href=?]", new_user_url, false, "Logged in users should not see a new user link"
    assert_select "a[href=?]", login_url, false, "Logged in users should not see a login link"
  end
end
