class CreateEventsPasses < ActiveRecord::Migration
  def change
    create_table :events_passes, id: false do |t|
      t.belongs_to :event, index: true
      t.belongs_to :pass, index: true
    end
  end
end
