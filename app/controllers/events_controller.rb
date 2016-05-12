class EventsController < ApplicationController
  before_action :set_event, only: [:edit, :update, :destroy, :arrival_count]

  # GET /events
  def index
    @events = Event.order(date: :asc).all
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  def create
    @event = Event.new(event_params)
    @event.name = event_params[:name]
    @event.date = DateTime.parse("#{event_params[:date]} #{event_params[:time]} -0300") if event_params[:date]
    if @event.save
      redirect_to events_path
    else
      render :new
    end
  end

  # PATCH/PUT /events/1
  def update
    @event.name = event_params[:name]
    @event.date = DateTime.parse("#{event_params[:date]} #{event_params[:time]} -0300") if event_params[:date]
    if @event.save
      redirect_to events_path
    else
      render :edit
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
    redirect_to events_url
  end

  def arrival_count
    @event.unregistered_attendees = params['door_counter']
    @event.save!
    render nothing: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params[:event].permit(:name, :date, :time)
    end
end
