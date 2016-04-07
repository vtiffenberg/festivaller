class Event < ActiveRecord::Base
  has_and_belongs_to_many :passes

  validates_presence_of :name, :date

  attr_accessor :time

  def registrants
    registrants = 0
    passes.each do |p|
      registrants += p.registrants.count
    end
    registrants
  end
end
