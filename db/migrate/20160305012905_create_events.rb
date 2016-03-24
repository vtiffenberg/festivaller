class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :date
      t.integer :unregistered_attendees

      t.timestamps null: false
    end
  end
end
