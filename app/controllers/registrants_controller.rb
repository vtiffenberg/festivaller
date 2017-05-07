class RegistrantsController < ApplicationController

  before_action :set_registrant, only: [:edit, :update, :sign_in, :pay]

  def index
    @registrants = Registrant.order(:name).all
  end

  def upload
  end

  def bulk_create
    csv = params[:csv].open
    @result = Registrant.parse(csv)
    @error_count = @result.count{|r| r[:error]}
    @paid_count = @result.count{|r| r[:registered_payment]}
    @empty_pass = @result.count{|r| r[:warning] == :empty_pass}
    render 'upload'
  end

  def edit
  end

  def update
    adding_pass = true if @registrant.pass_id.nil? && registrant_params[:pass_id].present?
    if @registrant.update(registrant_params)
      if adding_pass
        redirect_to empty_pass_registrants_path
      else
        redirect_to registrants_path
      end
    else
      render :edit
    end
  end

  def sign_in
    @registrant.signed_in = true
    @registrant.save!
    render nothing: true
  end

  def pay
    @registrant.paid = true
    @registrant.paid_at_event = params[:event_id]
    @registrant.save!
    render nothing: true
  end

  def empty_pass
    @registrants = Registrant.where(pass_id: nil).order(:name).all
    render 'index'
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_registrant
      @registrant = Registrant.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def registrant_params
      params[:registrant].permit(:name, :email, :pass, :level, :role, :signed_in, :paid, :paid_at_event, :pass_id)
    end

end
