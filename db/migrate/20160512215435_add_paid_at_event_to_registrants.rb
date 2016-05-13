class AddPaidAtEventToRegistrants < ActiveRecord::Migration
  def change
    add_column :registrants, :paid_at_event, :integer
  end
end
