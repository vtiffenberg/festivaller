class RegistrantsController < ApplicationController

  before_action :set_registrant, only: [:edit, :update]

  def index
    @registrants = Registrant.all
  end

  def upload
  end

  def bulk_create
    csv = params[:csv].open
    @result = Registrant.parse(csv)
    render 'upload'
  end

  def edit
  end

  def update
    if @registrant.update(registrant_params)
      redirect_to registrants_path
    else
      render :edit
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_registrant
      @registrant = Registrant.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def registrant_params
      params[:registrant].permit(:name, :email, :pass, :level, :role)
    end

end
