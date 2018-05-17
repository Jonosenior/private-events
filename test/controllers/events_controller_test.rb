require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:valid)
    @other_user = users(:hannah)
    @event = events(:valid)
  end

  test 'should get index' do
    get events_path
    assert_response :success
  end

  test "should redirect new when not logged in" do
    get new_event_path
    assert_redirected_to login_url
  end

  test "should get new when logged in" do
    log_in_as(@user)
    get new_event_path
    assert_response :success
  end

  test "should get show" do
    get event_path(@event.id)
    assert_response :success
  end

  test "should redirect destroy when non-creator is logged-in" do
    log_in_as(@other_user)
    assert_no_difference 'Event.count' do
      delete event_path(@event)
    end
    assert_redirected_to root_url
  end

  test "should destroy when creator is logged-in" do
    log_in_as(@user)
    # debugger
    assert_difference 'Event.count' do
      delete event_path(@event)
      # delete :destroy, id: @event.id
      # delete :destroy, id: @user_destroy
    end
    assert_redirected_to root_url
  end
end
