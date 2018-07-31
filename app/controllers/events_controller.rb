require 'pry'

class EventsController < ApplicationController
  before_action :logged_in_user, only: [:new]
  before_action :user_is_creator, only: [:destroy]

  def new
    @event = Event.new
    @event.attendances.build
  end

  def create
    @event = current_user.created_events.new(event_params)
    if @event.save
      add_attendees
      flash[:success] = "Event created!"
      redirect_to @event
    else
      flash.now[:danger] = "Invalid information."
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def index
    @upcoming_events = Event.future
    @past_events = Event.past
  end

  def destroy
    Event.find(params[:id]).destroy
    flash[:success] = "Event deleted."
    redirect_to root_path
  end

  private
  def event_params
    params.require(:event).permit(:name, :description, :location, :date_time, attendees: [:names])
  end

  def add_attendees
  #  binding.pry
    params[:event][:attendees].split(" ").each do |a|
      u = User.find_by(name: a)
      next if u.nil?
      Attendance.new(user_id: u.id, event_id: @event.id).save
    end
  end

  def user_is_creator
    creator = Event.find(params[:id]).creator
    unless current_user == creator
      flash[:danger] = "Only the host can delete an event!"
      redirect_to root_path
    end
  end

end
