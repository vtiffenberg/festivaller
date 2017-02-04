class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date
      t.text :extras
      t.boolean :current, default: false

      t.timestamps null: false
    end

    add_column :events, :season_id, :integer
    add_column :passes, :season_id, :integer
    add_column :registrants, :season_id, :integer
    add_column :discounts, :season_id, :integer

    add_index :events, :season_id
    add_index :passes, :season_id
    add_index :registrants, :season_id
    add_index :discounts, :season_id
  end
end
