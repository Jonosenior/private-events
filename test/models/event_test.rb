require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @event = events(:valid)
  end

  test 'valid event' do
    #
    @event = Event.new(name: "25th Birthday Party",   description: "Some lorem ipsum text about the party.",   date_time: "2018-09-24 12:45:00", location: "Repeater Bar", creator_id: 5)
    puts @event.errors.messages
    assert @event.valid?
  end

end
