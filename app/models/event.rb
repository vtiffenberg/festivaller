class Event < ActiveRecord::Base
  has_and_belongs_to_many :passes
  belongs_to :season

  validates_presence_of :name, :date

  attr_accessor :time

  scope :current, -> { where(season_id: Season.current_id) }
  default_scope { current }

  before_create :add_season

  def registrants
    registrants = 0
    passes.uniq.each do |pass|
      registrants += pass.registrants.count
    end
    registrants
  end

  def add_season
    self.season_id = Season.current_id unless self.season_id
  end
end
