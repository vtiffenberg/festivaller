class AddCurrentAttendeeCountToEvents < ActiveRecord::Migration
  def change
    add_column :events, :current_attendee_count, :integer, default: 0
  end
end
