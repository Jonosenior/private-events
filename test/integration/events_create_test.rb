require 'test_helper'

class EventsCreateTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:valid)
    @current_user = @user
  end

  test "invalid create information" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: "donuts" }}
    get new_event_url
    assert_select "form#new_event"
    assert_no_difference 'Event.count' do
      post events_path, params: { event: {   name: "  ",
                                             location: " ",
                                             date_time: Time.now,
                                             description: " ",
                                             attendees: " " }}
    end
    refute flash.empty?
  end

  test "valid create information" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: "donuts" }}
    assert is_logged_in?
    get new_event_url
    assert_select "form#new_event"
    assert_difference 'Event.count' do
      post events_path, params: { event: {   name: "Housewarming",
                                             location: "Jonathan's House",
                                             date_time: Time.now + 100.days,
                                             description: "Settlers of Catan night!",
                                             attendees: "Hannah Dan" }}
    end
    refute flash.empty?
    follow_redirect!
    assert_select "div", /Housewarming/
    assert_select "div", /Hannah/, "Existing users should appear"
    assert_select "div", { html: /Dan/, count: 0 }, "Non-existent users should not appear"
  end

end
