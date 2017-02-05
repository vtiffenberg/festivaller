class Season < ActiveRecord::Base
  has_many :events
  has_many :passes
  has_many :registrants

  validates_presence_of :name

  def self.current_id
    Rails.cache.fetch("current_season_id") { Season.where(current: true).first.id }
  end

  def self.current
    Season.where(current: true).first
  end

  def set_as_current
    Rails.cache.delete("current_season_id")
    Season.update_all(current: false)
    self.current = true
    save
  end
end
