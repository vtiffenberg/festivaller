class Discount < ActiveRecord::Base
  validates_presence_of :start, :end, :percentage, :name
end
