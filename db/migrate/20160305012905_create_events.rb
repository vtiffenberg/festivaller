class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :date
      t.integer :unregistered_attendees, default: 0

      t.timestamps null: false
    end
  end
end
