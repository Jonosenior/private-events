require 'pry'
class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  # Form VIEW
  # title: ENTER_TITLE
  # attendees: Jonathan Ibrahim Rachel

  # for each attendee:
    #   1) Find their User Id (by entering the name)
    # 2) Add that user id to the Attendance table, with the Event ID
#
# params[:event][:attendees].split(" ").each do |a|
#     u = User.find_by(name:, params[:name])
#     Attendance.build(user_id: u.id, event_id: @event.id)
# end
#https://apidock.com/rails/v4.0.2/ActiveRecord/FinderMethods/find_by
#
  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      params[:event][:attendees].split(" ").each do |a|
          u = User.find_by(name: a)
          binding.pry
          Attendance.new(user_id: u.id, event_id: @event.id).save
          binding.pry
      end
      redirect_to @event
    else
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
    @attendees = @event.attendees
  end

  def index
    @events = Event.all
  end

  private
  def event_params
    params.require(:event).permit(:name, :description, :location, :date_time)
  end
end
