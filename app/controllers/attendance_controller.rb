class AttendanceController < ApplicationController

  def index
    current = event_happening_now
    if current
      redirect_to event_attendance_path(current.id)
    else
      @events = Event.all
    end
  end

  def event
    @event = Event.find(params[:id])
    @registrants = Registrant.joins(:pass)
      .select('registrants.name, level, role, passes.name AS pass_name, passes.price AS pass_price, colour, registrants.id, signed_in, pass_id, paid')
      .order('registrants.name').all
    @passes_with_cover = Pass.for_event(@event.id).pluck(:id)
  end

  private

    def event_happening_now
      Event.where('date <= ? AND date > ?', DateTime.now, DateTime.now - 6.hours).try(:first)
    end

end
