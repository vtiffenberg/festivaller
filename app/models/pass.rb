class Pass < ActiveRecord::Base
  has_many :registrants
  has_and_belongs_to_many :events
  belongs_to :season

  validates_presence_of :name, :price
  before_create :add_season

  scope :current, -> { where(season_id: Season.current_id ) }
  default_scope { current }
  scope :for_event, lambda{|e| current.where("passes.id IN (SELECT events_passes.pass_id FROM events_passes WHERE events_passes.event_id = ?)", e) }

  def add_season
    self.season_id = Season.current_id unless self.season_id
  end

  def self.find_by_name(name)
    return nil if name.nil?
    if name.match(/.*festival.*/)
      where("name LIKE (?)", "%festival%").first
    elsif name.match(/.*fiesta.*/)
      where("name LIKE (?)", "%fiesta%").first
    elsif name.match(/.*carta.*/)
      nil
    else
      Pass.find_by(name: name)
    end
  end

end
