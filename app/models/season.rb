class Season < ActiveRecord::Base
  has_many :events
  has_many :passes
  has_many :registrants

  validates_presence_of :name

  def self.current
    Season.where(current: true).first
  end
end
