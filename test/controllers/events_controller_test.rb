require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  def setup
    # @event = users(:valid).created_events.create(name: "25th Birthday Party", description: "Some lorem ipsum text about the party.", date_time: "2018-09-24 12:45:00", location: "Repeater Bar")
    @user = users(:valid)
    @event = events(:valid)
  end

  test 'index action should be success' do
    # debugger
    get events_path
    assert_response :success
  end

  test "should redirect new when not logged in" do
    get new_event_path
    assert_redirected_to login_url
  end

  test "should get new when logged in" do
    login(@user)
    get new_event_path
    assert_response :success
  end

  test "should get show" do
    get event_path(@event.id)
    assert_response :success
  end

end
