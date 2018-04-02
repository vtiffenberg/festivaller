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
    @season = Season.new(season_params.except(*UploadField.all_fields))
    fill_upload_fields(@season, season_params)

    if @season.valid? && @season.set_as_current
      redirect_to edit_season_path(@season)
    else
      render :new
    end
  end

  # PATCH/PUT /seasons/1
  def update
    @season = fill_upload_fields(@season, season_params)
    @season.assign_attributes(season_params.except(*UploadField.all_fields))
    if @season.save
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

    def fill_upload_fields(season, params)
      hsh = season.upload_fields_hash
      UploadField.obligatory_codes.each do |code|
        if hsh[code]
          season.upload_fields.find{|field| field.code == code}.text = params["upload_field_#{code}"]
        else
          season.upload_fields.build(code: code, text: params["upload_field_#{code}"])
        end
      end
      season = fill_options(season, params)
    end

    def fill_options(season, params)
      hsh = season.upload_fields_hash
      UploadField.option_codes.each do |code|
        season.upload_fields.find{|field| field.code == code}.options = params["upload_field_#{code}_options"].split(",")
      end
      season
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_season
      @season = Season.includes(:upload_fields).find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def season_params
      params[:season].permit(:name, :start_date, :end_date, :extras, :upload_field_name, :upload_field_email, :upload_field_pass, :upload_field_partner, :upload_field_level, :upload_field_role, :upload_field_paid, :upload_field_level_options)
    end
end
