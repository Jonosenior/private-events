# require 'pry'
class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.new(event_params)
    if @event.save
      add_attendees
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

  def add_attendees
    params[:event][:attendees].split(" ").each do |a|
      u = User.find_by(name: a)
      next if u.nil?
      Attendance.new(user_id: u.id, event_id: @event.id).save
    end
  end

end
