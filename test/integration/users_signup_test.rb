require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get new_user_url
    assert_no_difference 'User.count' do
      post users_path,  params:  { user:  { name: "",
                                            email: "jon@bla.com",
                                            password: "yo",
                                            password_confirmation: "not" }}
    end
  end

  test "valid signup information" do
    get new_user_url
    assert_difference 'User.count' do
      post users_path,  params:  { user:  { name: "Jonathan",
                                            email: "jon@gmail.com",
                                            password: "reallysafepassword",
                                            password_confirmation: "reallysafepassword" }}
    end
  end


end
