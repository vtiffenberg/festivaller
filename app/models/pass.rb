class Pass < ActiveRecord::Base
  has_many :registrants
  has_and_belongs_to_many :events

  validates_presence_of :name, :price
end
