class AddPaidToRegistrants < ActiveRecord::Migration
  def change
    add_column :registrants, :paid, :boolean, default: false
  end
end
