class UploadField < ActiveRecord::Base
  serialize :options

  def self.obligatory_codes
    ["name","level","role","email","partner","pass","paid"]
  end

  def self.option_codes
    ["level"]
  end

  def self.all_fields
    obligatory_codes.map{|c| "upload_field_#{c}"} + option_codes.map{|c| "upload_field_#{c}_options"}
  end
end
