class Pass < ActiveRecord::Base
  has_many :registrants
  has_and_belongs_to_many :events

  validates_presence_of :name, :price

  scope :for_event, lambda{|e| where("passes.id IN (SELECT events_passes.pass_id FROM events_passes WHERE events_passes.event_id = ?)", e) }
end
