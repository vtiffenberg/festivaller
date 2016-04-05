class PassesController < ApplicationController
  before_action :set_pass, only: [:show, :edit, :update, :destroy]

  # GET /passes
  def index
    @passes = Pass.order(price: :desc).all
    @discounts = Discount.all
  end

  # GET /passes/new
  def new
    @pass = Pass.new
  end

  # GET /passes/1/edit
  def edit
  end

  # POST /passes
  def create
    @pass = Pass.new(pass_params)

    if @pass.save
      save_events
      redirect_to passes_path
    else
      render :new
    end
  end

  # PATCH/PUT /passes/1
  def update
    if @pass.update(pass_params)
      save_events
      redirect_to passes_path
    else
      render :edit
    end
  end

  # DELETE /passes/1
  def destroy
    @pass.destroy
    redirect_to passes_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pass
      @pass = Pass.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def pass_params
      params[:pass].permit(:name, :price, :description, :colour, :events)
    end

    def save_events
      Event.all.each do |event|
        if @pass.events.to_a.include?(event) && !params[:pass][:events].include?(event.id.to_s)
          @pass.events.delete(event)
        elsif params[:pass][:events].include?(event.id.to_s)
          @pass.events << event
        end
      end
    end
end
