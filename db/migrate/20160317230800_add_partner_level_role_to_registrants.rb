class AddPartnerLevelRoleToRegistrants < ActiveRecord::Migration
  def change
    add_column :registrants, :partner, :string
    add_column :registrants, :level, :string
    add_column :registrants, :role, :string
  end
end
