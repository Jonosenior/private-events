require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @event = users(:valid).created_events.create(name: "25th Birthday Party", description: "Some lorem ipsum text about the party.", date_time: "2018-09-24 12:45:00", location: "Repeater Bar")
  end

  test 'index action should be success' do
    get events_path
    assert_template 'index'
  end

  # test "should get create" do
  #   get events_create_url
  #   assert_response :success
  # end
  #
  # test "should get show" do
  #   get events_show_url
  #   assert_response :success
  # end
  #
  # test "should get index" do
  #   get events_index_url
  #   assert_response :success
  # end
  #
end
