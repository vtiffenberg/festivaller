class SeasonsController < ApplicationController
  before_action :set_season, except: [:index, :new, :create]

  # GET /seasons
  def index
    @seasons = Season.all
  end

  # GET /seasons/new
  def new
    @season = Season.new
  end

  # GET /seasons/1/edit
  def edit
  end

  # POST /seasons
  def create
    @season = Season.new(season_params)

    if @season.valid? && @season.set_as_current
      redirect_to edit_season_path(@season)
    else
      render :new
    end
  end

  # PATCH/PUT /seasons/1
  def update
    if @season.update(season_params)
      redirect_to seasons_path
    else
      render :edit
    end
  end

  def set_current
    if @season.set_as_current
      redirect_to seasons_path
    else
      redirect_to seasons_path, notice: "No se pudo cambiar"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_season
      @season = Season.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def season_params
      params[:season].permit(:name, :start_date, :end_date, :extras)
    end
end
