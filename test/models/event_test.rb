require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @user = users(:valid)
    @event = events(:valid)
    @past_event = events(:past)
    # @event = users(:valid).created_events.new(name: "25th Birthday Party",   description: "Some lorem ipsum text about the party.",   date_time: "2018-09-24 12:45:00", location: "Repeater Bar")
  end

  test 'valid event' do
    assert @event.valid?
  end

  test 'name should be present' do
    @event.name = '  '
    refute @event.valid?
  end

  test 'description should be present' do
    @event.description = ' '
    refute @event.valid?
  end

  test 'location should be present' do
    @event.location = ' '
    refute @event.valid?
  end

  test 'date_time should not be in the past' do
    @event.date_time = "2017-09-24 12:45:00"
    refute @event.valid?
  end

  test 'future returns only future events' do
    assert Event.future.include?(@event)
    refute Event.future.include?(@past_event)
  end

  test 'past returns only past events' do
    refute Event.past.include?(@event)
    assert Event.past.include?(@past_event)
  end

  test 'invited users are added as attendees' do
    @event.attendees = "Hannah"
    assert @event.attendees.first.name == "Hannah"
  end

  test 'invited non-users are ignored' do
    @event.attendees = "Sandy"
    refute @event.attendees.first.name == "Sandy"
  end



end
