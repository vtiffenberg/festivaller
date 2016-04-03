class AttendanceController < ApplicationController

  def index
    if event_happening_now
      redirect_to :event, id: event_happening_now.id
    else
      @events = Event.all
    end
  end

  def event
    @event = Event.find(params[:id])
    @registrants = Registrant.order(:name).all
  end

  private

    def event_happening_now
      Event.where('date >= ? AND date < ?', DateTime.now, DateTime.now + 6.hours).try(:first)
    end

end
