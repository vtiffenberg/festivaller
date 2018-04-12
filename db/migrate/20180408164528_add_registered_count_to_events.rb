class AddRegisteredCountToEvents < ActiveRecord::Migration
  def change
    add_column :events, :registered_attendees, :integer, default: 0
  end
end
