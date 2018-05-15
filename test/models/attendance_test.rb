require 'test_helper'

class AttendanceTest < ActiveSupport::TestCase
  def setup
    @attendance = Attendance.new(user_id: User.first.id, event_id: Event.first.id)
  end

  test 'valid attendance' do
    assert @attendance.valid?
  end

  test 'user must be present' do
    @attendance.user_id = nil
    refute @attendance.valid?
  end

  test 'event must be present' do
    @attendance.event_id = nil
    refute @attendance.valid?
  end

end
