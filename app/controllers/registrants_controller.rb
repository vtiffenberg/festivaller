class RegistrantsController < ApplicationController

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

end
