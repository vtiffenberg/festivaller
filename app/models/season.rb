class Season < ActiveRecord::Base
  has_many :events
  has_many :passes
  has_many :registrants
  has_many :upload_fields
  accepts_nested_attributes_for :upload_fields

  validates_presence_of :name

  def upload_fields_hash
    hsh = {}
    upload_fields.each do |field|
      hsh[field.code] = field.text
      if field.code == "level"
        hsh["level_options"] = field.options
      end
    end
    hsh
  end

  def self.current_id
    Rails.cache.fetch("current_season_id") { Season.where(current: true).first.id }
  end

  def self.current
    Season.where(current: true).includes(:upload_fields).first
  end

  def set_as_current
    Rails.cache.delete("current_season_id")
    Season.update_all(current: false)
    self.current = true
    save
  end

  def levels
    upload_fields.find{|f| f.code == "level"}.try(:options)
  end
end
