class DiscountsController < ApplicationController
  before_action :set_discount, only: [:destroy]

  # GET /discounts/new
  def new
    @discount = Discount.new
  end

  # POST /discounts
  def create
    @discount = Discount.new(discount_params)

    if @discount.save
      redirect_to passes_path
    else
      render :new
    end
  end

  # DELETE /discounts/1
  def destroy
    @discount.destroy
    redirect_to passes_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discount
      @discount = Discount.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def discount_params
      params[:discount].permit(:start, :end, :percentage, :name)
    end
end
